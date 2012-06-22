# Extjs::Rails

This is a simple Rails asset pipeline gem packaging the [Sencha Ext JS
Framework](http://www.sencha.com/products/extjs/) (GPL version). It is
based on [ext\_rails\_shim](https://github.com/sakuro/ext_rails_shim), 
but without any Rails integration besides making the assets available to
the asset pipeline.

The Ext JS default themes have been recompiled to update the image
assets paths to conform to Rails asset pipeline conventions.

The currently bundled version is Ext JS 4.1.0 GPL

## Installation

Add this line to your application's Gemfile:

    gem 'extjs-rails'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install extjs-rails

## Usage

Just include the desired theme css file

    <%= stylesheet_include_tag 'ext4/ext-all' %>

and JS file

    <%= javascript_include_tag 'ext4/ext-all' %> 

Note: The ext-all\*.js versions should be used, as Ext JS' dynamic class
loading is incompatible with the asset pipeline.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
