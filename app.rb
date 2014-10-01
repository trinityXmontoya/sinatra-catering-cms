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
    js :demo1, [
      '/js/agency.js',
      '/js/bootstrap.js',
      '/js/bootstrap.min.js',
      '/js/cbpAnimatedHeader.js',
      '/js/cbpAnimatedHeader.min.js',
      '/js/classie.js',
      '/js/contact_me.js',
      '/js/jqBootstrapValidation.js',
      '/js/jquery-1.11.0.js'
    ]
    js :demo2, [
      '/js/bootstrap.min.js',
      '/js/animation.js',
      '/js/carousels.js',
      '/js/classie.js',
      '/js/modernizr.js',
      '/js/normal.js',
      '/js/slider-modernizr.js',
      '/js/portfolio-effects.js',
      '/js/toucheffects.js'
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
      css :demo1, [
        '/css/agency.css',
        '/css/bootstrap.min.css'
       ]
       css :demo2, [
       '/css/bootstrap.min.css',
       '/css/animation.css',
       '/css/normal.css',
       '/css/style1.css',
       '/css/hoverex-all.css'
       ]


    js_compression :jsmin
    css_compression :sass
  end
end

require './auth'
require './routes'
