Dir["./models/*.rb"].each {|file| require file }

get '/' do
  erb :index
end

get '/menu' do
  @categories = Category.includes(:menu_items)
  erb :menu
end

get '/about' do
  erb :about
end

get '/contact' do
  erb :contact
end

get '/testimonials' do
  @testimonials = Testimonial.all
  @testimonial = Testimonial.
  new
  erb :testimonials
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

get '/*' do
  redirect "/"
end
