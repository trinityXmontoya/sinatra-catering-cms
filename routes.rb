class CateringApp

  # require all models
  Dir["./models/*.rb"].each {|file| require file }

  # ------------------------------------
  # MAIN
  # ------------------------------------
  get '/' do
    @testimonials = Testimonial.approved
    @testimonial = Testimonial.new
    @categories = Category.all.includes(:menu_items)
    @site = SiteInfo.find(1)
    @gallery_images = GalleryImage.all
    erb :'main/index'
  end

  post '/testimonials' do
    testimonial = Testimonial.new(
                      params[:testimonial],
                      approved: false)
    if testimonial.save
      flash[:notice] = "Submitted for approval."
    else
      flash[:notice] = "Error adding."
    end
    redirect '/'
  end

  post '/contact' do
    send_mail(params[:name],params[:email],params[:phone],params[:message])
  end

  # ------------------------------------
  # ADMIN
  # ------------------------------------

  # layout as params
  def admin_layout
    {layout: 'admin/layout'}
  end

  before '/admin/*' do
    authorize!
  end

  get '/login' do
    erb :'admin/login'
  end

  post '/login' do
    if verify_credentials(params[:admin])
      session[:user] = "admin"
      redirect '/admin'
    else
      flash[:notice] = "Error logging in."
      redirect '/login'
    end
  end

  get '/admin' do
    @site = SiteInfo.find(1)
    erb :'admin/site_info', admin_layout
  end

  get %r{/admin/categories/?$}i do
    @categories = Category.all
    @category = Category.new
    erb :'admin/categories1', admin_layout
  end

  get '/admin/menu_items' do
    @menu_items = MenuItem.all
    @menu_item = MenuItem.new
    erb :'admin/menu_items', admin_layout
  end

  get '/admin/site_photos' do
    @site = SiteInfo.find(1)
    @gallery_images = GalleryImage.all
    erb :'admin/site_photos', admin_layout
  end

  get %r{/admin/testimonials/?$}i do
    @testimonials = Testimonial.all
    erb :'admin/testimonials', admin_layout
  end

  delete '/logout' do
    session.clear
    flash[:notice] = "Logged out"
    redirect '/'
  end

  post '/admin/categories' do
    create_obj("category",params[:category])
  end

  post '/admin/menu_items' do
    create_obj("menu_item",params[:menu_item])
  end

  post '/admin/site_photos' do
    create_obj("site_photos",params[:category])
  end

  put '/admin/:type/:id' do
    type = params[:type]
    puts "IM HERE"
    puts type
    if type == "site_info"
      SiteInfo.find(1).update(params[:site_info])
      redirect '/admin'
    else
      obj = find_class(type).find(params[:id])
      if type == "testimonial"
        obj.update(approved: !to_boolean(params[:value]))
        obj.save
      end
    end
  end

  delete '/admin/:type/:id' do
    destroy_obj(params[:type],params[:id])
  end

  # ------------------------------------
  # REDIRECT
  # ------------------------------------

  get '/*' do
    flash[:notice] = "page not found"
    redirect '/'
  end


  # ------------------------------------
  # METHODS
  # ------------------------------------

  def success_msg
    flash[:notice]="Succesfully created"
  end

  def error_msg
    flash[:notice]="Error saving."
  end

  # since the value is coming from the database I know it is already lowercase
  def to_boolean(str)
    str == 'true'
  end

  def find_class(type)
    if type.include? "_"
      klass = type.split("_").map {|x| x.capitalize}.join
    else
      klass = type.capitalize
    end
    return klass.constantize
  end

  def create_obj(type,obj_params)
    obj = find_class(type).new(obj_params)
    unless type == "testimonial"
      obj.save ? success_msg : error_msg
      redirect "/admin/#{type.pluralize}"
    else
      # obj.save ?
    end
  end

  def destroy_obj(type,id)
    find_class(type).destroy(id)
    redirect "/admin/#{type.pluralize}", flash[:notice]="Item deleted."
  end


  def send_mail(name,email,phone,message)
    Pony.mail :reply_to => email,
              :body =>
              "You have received a new message from your website contact form.\n\n
               Here are the details:\n\n
               Name: #{name}\n\n
               Email: #{email}\n\n
               Phone: #{phone}\n\n
               Message:\n#{message}"
  end



end
