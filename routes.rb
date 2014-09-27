class CateringApp < Sinatra::Application

  # require all models
  Dir["./models/*.rb"].each {|file| require file }

  # MAIN
  # ------------------------------------
  configure do
    set :erb, :layout => :'main/layout'
  end

  get '/' do
    erb :'main/index'
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
    erb :'main/testimonials'
  end

  # ADMIN
  # ------------------------------------
  get '/login' do
    erb :'admin/login', layout: :'admin/layout'
  end

  post '/testimonials' do
    testimonial = Testimonial.new(params[:testimonial])
    if testimonial.save
      erb :testimonials; flash[:notice] = "Error saving."
    else
      erb :testimonials
    end
  end

  post '/categories' do
  end

  post '/menu_items' do
  end

  # REDIRECT

  get '/*' do
    redirect '/'
  end
end
