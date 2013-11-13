# Main repo moved

As I don't use Ext JS any more in my projects, I won't find the time to
maintain this gem. However, @tlrdstd has agreed to take it over at his
fork at https://github.com/tlrdstd/extjs4-rails. Thanks again, Tyler!


# Extjs4::Rails

This is a simple Rails asset pipeline gem packaging the [Sencha Ext JS
Framework](http://www.sencha.com/products/extjs/) (GPL version). It is
based on [ext\_rails\_shim](https://github.com/sakuro/ext_rails_shim),
but without any Rails integration besides making the assets available to
the asset pipeline.

The Ext JS default themes have been recompiled to update the image
assets paths to conform to Rails asset pipeline conventions.

The currently bundled version is Ext JS 4.2.1.883 GPL.

## Installation

Add this line to your application's Gemfile:

    gem 'extjs4-rails'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install extjs4-rails

## Usage

Just include the desired theme css file

    <%= stylesheet_include_tag 'extjs4-rails/ext-all' %>

and JS file

    <%= javascript_include_tag 'extjs4-rails/ext-all-classic' %>

Don't forget to add the chosen files to config.assets.precompile

    config.assets.precompile << 'extjs4-rails/ext-all.js'
    config.assets.precompile << 'extjs4-rails/ext-all-classic.css'

Note: The ext-all\*.js versions should be used, as Ext JS' dynamic class
loading is incompatible with the asset pipeline.

You can also include specific files from the Sencha UX folders

    <%= javascript_include_tag 'extjs4-rails/src/ux/grid/menu/RangeMenu' %>

## Rake task

You can fork this gem and run

    EXTJS_DIR=/path/to/extjs-4.x.x EXTJS_THEME=classic rake --trace extjs4-rails:install

to rebuild Ext JS, i.e. when you built your own theme.

EXTJS_THEME can be set to classic or neptune to build the preinstalled Sencha themes.
Set to the name of your own theme as appropriate.

## License

[GPLv3](http://www.gnu.org/copyleft/gpl.html) like Ext JS.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
