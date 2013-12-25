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

  s.add_dependency "rails", "~> 4.0.0"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "factory_girl_rails"

end
