class CateringApp

  # require all models
  Dir["./models/*.rb"].each {|file| require file }

  # layout as params
  def admin_layout
    {layout: 'admin/layout'}
  end

  # ------------------------------------
  # MAIN
  # ------------------------------------
  get '/' do
    @testimonials = Testimonial.all
    @categories = Category.all.includes(:menu_items)
    erb :'main/index'
  end

  post '/testimonials' do
    testimonial = Testimonial.new(params[:testimonial])
    if testimonial.save
      erb :'main/index'; flash[:notice] = "Error saving."
    else
      erb :'main/index'
    end
  end

  post '/contact' do
    send_mail(params[:name],params[:email],params[:phone],params[:message])
  end

  # ------------------------------------
  # ADMIN
  # ------------------------------------

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
    erb :'admin/general', admin_layout
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

  get '/admin/site_photos' do
    @categories = Category.all
    @categort = Category.new
    erb :'admin/site_photos', admin_layout
  end

  get '/admin/testimonials' do
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

  delete '/admin/:type/:id' do
    destroy_obj(params[:obj],params[:id])
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

  def create_obj(type,obj)
    if type.includes? "_"
      klass = type.split("_").map {|x| x.capitalize}.join
    else
      klass = type.capitalize
    end
    obj = klass.constantize.new(obj)
    obj.save ? success_msg : error_msg
    redirect "/admin/#{type.pluralize}"
  end

  def destroy_obj(type,id)
    if type.includes? "_"
      obj = type.split("_").map {|x| x.capitalize}.join
    else
      obj = type.capitalize.constantize.destroy(id)
    end
    obj.save ? success_msg : error_msg
    redirect "/admin/#{type.pluralize}"
  end


  def send_mail(name,email,phone,message)
    Pony.mail :reply_to => email,
              :body =>
              "You have received a new message from your website contact form.\n\n Here are the details:\n\nName: #{name}\n\nEmail: #{email}\n\nPhone: #{phone}\n\nMessage:\n#{message}"
  end



end
