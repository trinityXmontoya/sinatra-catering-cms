require 'dotenv'
Dotenv.load

require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/reloader'
require 'sinatra/flash'
require 'padrino-helpers'
require './environment'

class CateringApp < Sinatra::Application
  enable :protect_from_csrf
  use Rack::Session::Cookie, :secret => ENV['SESSION_SECRET']
  # include Padrino::Helpers::OutputHelpers
  # include Padrino::Helpers::TagHelpers
  # include Padrino::Helpers::AssetTagHelpers
  # include Padrino::Helpers::FormHelpers
  register Padrino::Helpers
end

require './auth'
require './routes'
