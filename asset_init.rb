class CateringApp
  assets do
    serve '/js', :from => 'public/javascripts'

    js :application, [
      '/js/classie.js',
      '/js/jqBootstrapValidation.js',
      '/js/contact_me.js',
      '/js/agency.js'
    ]
    js :admin, [
      '/js/admin.js',
      '/js/plugins/metisMenu/*.js',
      '/js/sb-admin-2.js'
    ]

    serve '/css', :from => 'public/stylesheets'
    css :application, [
      '/css/agency.css'
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
