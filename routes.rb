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
    obj_params = params[:testimonial]
    obj = create_obj("testimonial", obj_params)
    if obj.save
      notify_of_testimonial(obj_params)
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

  delete '/logout' do
    session.clear
    flash[:notice] = "Logged out"
    redirect '/login'
  end

  get '/admin' do
    @site = SiteInfo.find(1)
    erb :'admin/site_info', admin_layout
  end

  get '/admin/categories' do
    @categories = Category.all
    @category = Category.new
    erb :'admin/categories', admin_layout
  end

  get '/admin/menu_items' do
    @menu_items = MenuItem.all
    @menu_item = MenuItem.new
    erb :'admin/menu_items', admin_layout
  end

  get '/admin/gallery_images' do
    @gallery_images = GalleryImage.all
    @gallery_image = GalleryImage.new
    erb :'admin/gallery_images', admin_layout
  end

  get '/admin/testimonials' do
    @testimonials = Testimonial.all
    erb :'admin/testimonials', admin_layout
  end

  post '/admin/:type' do
    type = params[:type].singularize
    obj = create_obj(type, params[type.to_sym])
    obj.save ? success_msg : error_msg
    redirect "/admin/#{params[:type]}"
  end

  put '/admin/:type/:id' do
    type = params[:type]
    obj = find_class(type).find(params[:id])
    if type == "testimonial"
      obj.toggle_approved
    else
      obj.update(params[type.to_sym])
    end
    obj.save ? success_msg : error_msg
    redirect "/admin/#{type.pluralize}"
  end

  delete '/admin/:type/:id' do
    if destroy_obj(params[:type],params[:id])
      flash[:notice]="Item deleted."
    else
      error_msg
    end
      redirect "/admin/#{params[:type].pluralize}"
  end


  # ------------------------------------
  # REDIRECTS
  # ------------------------------------

  get '/admin/*' do
    redirect '/admin'
  end

  get '/*' do
    flash[:notice] = "page not found"
    redirect '/'
  end


  # ------------------------------------
  # METHODS
  # ------------------------------------

  def success_msg
    flash[:notice]="Succesfully saved."
  end

  def error_msg
    flash[:notice]="Error saving."
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
    find_class(type).new(obj_params)
  end

  def destroy_obj(type,id)
    find_class(type).destroy(id)
  end

  def send_mail(name,email,phone,message)
    Pony.mail :reply_to => email,
              :subject => "Anousheh-Catering.com - Contact Form",
              :body =>
              "You have received a new message from your website contact form.\n\n
               Here are the details:\n\n
               Name: #{name}\n\n
               Email: #{email}\n\n
               Phone: #{phone}\n\n
               Message:\n#{message}"
  end

  def notify_of_testimonial(testimonial)
    Pony.mail :subject => "Anousheh-Catering.com - Testimonial",
              :headers => { 'Content-Type' => 'text/html' },
              :body =>
              "You have received a new testimonial.<br>
               Here are the details:<br>
               Name: #{testimonial[:name]}<br>
               Event: #{testimonial[:event]}<br>
               Comment: #{testimonial[:comment]}<br>
               <a href='http://www.anousheh-catering.com/login'>Login to approve.</a>"
  end



end
