class CateringApp

  # require all models
  Dir["./models/*.rb"].each {|file| require file }

  # MAIN
  # ------------------------------------
  set :erb, layout: :'main/layout'

  get '/' do
    erb :'main/index', layout: :'main/layout'
  end

  get '/menu' do
    @categories = Category.includes(:menu_items)
    erb :'main/menu'
  end

  get '/about' do
    erb :'main/about'
  end

  get '/contact' do
    erb :'main/contact'
  end

  get '/testimonials' do
    @testimonials = Testimonial.all
    @testimonial = Testimonial.new
    erb :'main/testimonials'
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
    erb :'admin/login', layout: :'admin/layout'
  end

  post '/login' do
    if verify_credentials(params[:admin])
      session[:user] = "admin"
      redirect '/testimonials'
    else
      flash[:notice] = "Error logging in."
      redirect '/login'
    end
  end

  get '/admin' do
    @categories = Category.all
    @category = Category.new
    @menu_items = MenuItem.all
    @menu_item = MenuItem.new
    @testimonials = Testimonial.all
    @testimonial = Testimonial.new
    erb :'admin/dashboard'
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
