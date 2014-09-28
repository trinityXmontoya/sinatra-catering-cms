require 'dotenv'
Dotenv.load

require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/reloader'
require 'sinatra/flash'
require 'padrino-helpers'
require './environment'
require 'sinatra/assetpack'

class CateringApp < Sinatra::Application
  enable :protect_from_csrf
  use Rack::Session::Cookie, :secret => ENV['SESSION_SECRET']
  # include Padrino::Helpers::OutputHelpers
  # include Padrino::Helpers::TagHelpers
  # include Padrino::Helpers::AssetTagHelpers
  # include Padrino::Helpers::FormHelpers
  register Padrino::Helpers
  register Sinatra::AssetPack
  assets do
    serve '/js', :from => 'public/javascripts'
    js :application, [
      '/js/*.js'
    ]

    js :admin, [
      '/js/admin.js',
      '/js/plugins/metisMenu/*.js',
      '/js/sb-admin-2.js'
    ]

    serve '/css', :from => 'public/stylesheets'
    css :application, [
      '/css/plugins/*.css',
      '/css/plugins/metisMenu/*.css',
      '/css/.css'
     ]
     css :admin, [
       '/css/plugins/*.css',
       '/css/plugins/metisMenu/*.css',
       '/css/*.css'
      ]

    js_compression :jsmin
    css_compression :sass
  end
end

require './auth'
require './routes'
