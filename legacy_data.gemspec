$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "legacy_data/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "legacy_data"
  s.version     = LegacyData::VERSION
  s.authors     = ["David Connolly"]
  s.email       = ["davidjconnolly@gmail.com"]
  s.homepage    = "github.com/davidconnolly"
  s.summary     = "A tool to facilitate importing fragmented data sources into Rails Applications"
  s.description = "A tool to facilitate importing fragmented data sources into Rails Applications"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.4"

  s.add_development_dependency "pg"
end
