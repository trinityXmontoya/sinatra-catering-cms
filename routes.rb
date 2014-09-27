Dir["./models/*.rb"].each {|file| require file }

get '/' do
  erb :'index.html'
end

get '/menu' do
  erb :'menu.html'
end

get '/about' do
  erb :'about.html'
end

get '/contact' do
  erb :'contact.html'
end

get '/testimonials' do
  @testimonials = Testimonial.all
  erb :'testimonials.html'
  flash[:notice] = "Hey boys"
end

post '/testimonials' do
  testimonial = Testimonial.new(params[:testimonial])
  if testimonial.save
    erb :'testimonials.html', flash[:notice] = "Error saving."
  else
    erb :'testimonials.html'
  end
end

post '/categories' do
end

post '/menu_items' do
end
