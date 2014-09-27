require 'dotenv'
Dotenv.load

require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/reloader'
require 'sinatra/flash'
require 'sinatra/static_assets'
require './environment'
require './routes'

class CateringApp < Sinatra::Application
  enable :sessions
end



