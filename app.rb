# app.rb

enable :sessions

require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/reloader'
require 'sinatra/flash'
require './environment'
require './routes'
