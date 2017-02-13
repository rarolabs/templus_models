$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "templus_models/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "templus_models"
  s.version     = TemplusModels::VERSION
  s.authors     = ["Rodrigo Sol", "Leonardo Herbert", "Diego Lima"]
  s.email       = ["rodrigo@rarolabs.com.br","leonardo@rarolabs.com.br","lima@rarolabs.com.br"]
  s.homepage    = "http://github.com/rarolabs/templus_models"
  s.summary     = "Easy CRUD generator for Rails Projects"
  s.description = "Easy CRUD generator for Rails Projects"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "> 4.1.0"
  s.add_dependency "cancancan", "> 1.10"
  s.add_dependency "ransack", "> 1.6.3"
  s.add_dependency "kaminari", "~> 0.16"
  s.add_dependency "simple_form", "> 3.1.0"
  s.add_dependency "nested_form"
  s.add_dependency "rails-jquery-autocomplete"
  s.add_dependency "wicked_pdf"

  s.add_development_dependency "sqlite3"
end
