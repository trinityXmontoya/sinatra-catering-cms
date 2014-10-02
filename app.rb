require 'dotenv'
Dotenv.load

require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/reloader'
require 'sinatra/flash'
require 'sinatra/assetpack'
require 'padrino-helpers'

class CateringApp < Sinatra::Application
  enable :protect_from_csrf
  use Rack::Session::Cookie, :secret => ENV['SESSION_SECRET']
  register Padrino::Helpers
  register Sinatra::AssetPack
end

require './db_init'
require './pony_init'
require './asset_init'
require './auth'
require './routes'
