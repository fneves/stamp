require 'sass-rails'
require 'bootstrap-sass'
require 'formtastic-bootstrap'
require 'font-awesome-sass'
# require 'mongoid'
# require 'jquery-rails'


module Stamp
  class Engine < ::Rails::Engine
    isolate_namespace Stamp

    config.generators do |g|
      g.test_framework      :rspec,        :fixture => false
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
      g.assets false
      g.helper false
    end

  end
end
