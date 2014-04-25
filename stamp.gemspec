$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "stamp/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "stamp"
  s.version     = Stamp::VERSION
  s.authors     = ["Fabio Neves"]
  s.email       = ["fabio.miguel.neves@gmail.com"]
  s.homepage    = "http://www.gihub.com/fneves/stamp"
  s.summary     = "Reservation system."
  s.description = "A rails reservation system engine that plugs into your application seamlessly"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  #s.test_files = Dir["test/**/*"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.0.3"
  s.add_dependency 'sass-rails', '~> 4.0.2'

  s.add_development_dependency 'activemerchant'
  s.add_development_dependency 'jquery-rails'
  s.add_development_dependency 'will_paginate', '~> 3.0'

  s.add_development_dependency 'jquery-datatables-rails'#, github: 'rweng/jquery-datatables-rails'
  s.add_development_dependency 'jquery-ui-rails'

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "simplecov"
  #s.add_development_dependency "simple_form"

  s.add_development_dependency 'bootstrap-sass'
  s.add_development_dependency "formtastic-bootstrap", "~> 3.0.0"
  s.add_development_dependency 'font-awesome-sass'

  #graphics
  s.add_development_dependency 'chartkick'
  s.add_development_dependency 'groupdate'

  # better errors with prompt :) - only on development
  # localhost:3000/__better_errors - show the last exception
  s.add_development_dependency 'better_errors'
  s.add_development_dependency 'binding_of_caller'
  # for use of RailsPanel chrome extension (on chrome debug console)
  s.add_development_dependency 'meta_request'


  # Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
  #s.add_development_dependency 'turbolinks'

end
