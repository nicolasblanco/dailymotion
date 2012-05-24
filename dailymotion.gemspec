# -*- encoding: utf-8 -*-
require File.expand_path('../lib/dailymotion/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["slainer68"]
  gem.email         = ["slainer68@gmail.com"]
  gem.description   = %q{Dailymotion Open Graph API for Ruby}
  gem.summary       = %q{Dailymotion Open Graph API for Ruby}
  gem.homepage      = "https://github.com/slainer68/dailymotion"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "dailymotion"
  gem.require_paths = ["lib"]
  gem.version       = Dailymotion::VERSION

  gem.add_runtime_dependency "faraday"
  gem.add_runtime_dependency "hashie"
  gem.add_runtime_dependency "faraday_middleware"

  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec', '~> 2.10.0'
end
