$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "stamp/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "stamp"
  s.version     = Stamp::VERSION
  s.authors     = ["Fabio Neves"]
  s.email       = ["fabio.miguel.neves@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Stamp."
  s.description = "TODO: Description of Stamp."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.0"

  s.add_development_dependency "sqlite3"
end
