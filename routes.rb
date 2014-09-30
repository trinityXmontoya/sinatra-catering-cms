class CateringApp

  # require all models
  Dir["./models/*.rb"].each {|file| require file }

  # layout as params
  def admin_layout
    {layout: 'admin/layout'}
  end

  def main_layout
    {layout: 'main/layout'}
  end

  # MAIN
  # ------------------------------------
  get '/' do
    erb :'main/index', main_layout
  end

  get '/demo1' do
    @testimonials = Testimonial.all
    @categories = Category.all.includes(:menu_items)
    erb :"main/demo1"
  end

  get '/menu' do
    @categories = Category.includes(:menu_items)
    erb :'main/menu', main_layout
  end

  get '/about' do
    erb :'main/about', main_layout
  end

  get '/contact' do
    erb :'main/contact', main_layout
  end

  get '/gallery' do
    erb :'main/gallery', main_layout
  end

  get '/testimonials' do
    @testimonials = Testimonial.all
    @testimonial = Testimonial.new
    erb :'main/testimonials', main_layout
  end

  get '/new_testimonial' do
    erb :'main/new_testimonials', main_layout
  end

  post '/testimonials' do
    testimonial = Testimonial.new(params[:testimonial])
    if testimonial.save
      erb :testimonials; flash[:notice] = "Error saving."
    else
      erb :testimonials
    end
  end

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

  # REDIRECT

  get '/*' do
    flash[:notice] = "page not found"
    redirect '/'
  end

end
