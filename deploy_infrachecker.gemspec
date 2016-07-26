$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "samson_deploy_infrachecker/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "deploy_infrachecker"
  s.version     = SamsonDeployInfrachecker::VERSION
  s.authors     = ["Redbubble"]
  s.email       = [""]
  s.homepage    = "https://github.com/redbubble/samson-deploy-infrachecker"
  s.summary     = "A Samson plugin that prevents deployment if the infra spec build is red."
  s.description = "A Samson plugin that prevents deployment if the infra spec build is red."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_development_dependency 'httpclient', '~> 2.8.0'
  s.add_development_dependency "minitest", '~> 5.9.0'
  s.add_development_dependency "maxitest", '~> 2.0.2'
  s.add_development_dependency "mocha", '~> 1.1.0'
end
