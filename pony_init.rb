require 'pony'
Pony.options = {
  :to => 'montoyat93@gmail.com',
  :subject => "Anousheh-Catering.com - Contact Form",
  :via => :smtp,
  :via_options => {
    :address              => 'smtp.gmail.com',
    :port                 => '587',
    :enable_starttls_auto => true,
    :user_name            => ENV["EMAIL_USERNAME"],
    :password             => ENV["EMAIL_PASSWORD"],
    :authentication       => :plain
    }
}
