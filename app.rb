require 'dotenv'
Dotenv.load

require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/reloader'
require 'sinatra/flash'
require 'sinatra/assetpack'
require 'padrino-helpers'
require 'pony'
require 'carrierwave'
require 'carrierwave/orm/activerecord'

# require all uploader files
Dir["./uploaders/*.rb"].each {|file| require file }

class CateringApp < Sinatra::Application
  enable :protect_from_csrf
  use Rack::Session::Cookie, :secret => ENV['SESSION_SECRET']
  register Padrino::Helpers
  register Sinatra::AssetPack
end

# require all config files
Dir["./config/*.rb"].each {|file| require file }
require './auth'
require './routes'
