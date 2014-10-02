require 'dotenv'
Dotenv.load

require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/reloader'
require 'sinatra/flash'
require 'sinatra/assetpack'
require 'padrino-helpers'
require 'pony'


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
