# -*- encoding: utf-8 -*-
require File.expand_path('../lib/extjs4-rails/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Paul Schyska"]
  gem.email         = ["pschyska@googlemail.com"]
  gem.description   = %q{See README.md}
  gem.summary       = %q{Rails asset gem for Sencha's Ext JS Framework }
  gem.homepage      = "https://github.com/pschyska/extjs4-rails"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "extjs4-rails"
  gem.require_paths = ["lib"]
  gem.version       = Extjs4::Rails::VERSION

  gem.add_dependency "rake"
  gem.add_dependency "compass"
end
