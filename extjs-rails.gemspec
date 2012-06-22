# -*- encoding: utf-8 -*-
require File.expand_path('../lib/extjs-rails/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Paul Schyska"]
  gem.email         = ["pschyska@googlemail.com"]
  gem.description   = %q{See README.md}
  gem.summary       = %q{Rails asset gem for Sencha's Ext JS Framework }
  gem.homepage      = "https://github.com/pschyska/extjs-rails"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "extjs-rails"
  gem.require_paths = ["lib"]
  gem.version       = Extjs::Rails::VERSION

  gem.add_dependency "rake"
  gem.add_dependency "compass"
end
