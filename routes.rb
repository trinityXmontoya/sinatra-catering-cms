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

  get '/testimonials' do
    @testimonials = Testimonial.all
    @testimonial = Testimonial.new
    erb :'main/testimonials', main_layout
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

  post 'admin/categories' do
  end

  post 'admin/menu_items' do
  end

  # REDIRECT

  get '/*' do
    flash[:notice] = "page not found"
    redirect '/'
  end

end
