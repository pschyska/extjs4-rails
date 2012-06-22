# based on https://raw.github.com/sakuro/ext_rails_shim/master/config/compass_init.rb @e0c05fade1a16601714cf9fd822e61321ab6dfc2
# based on ext-4.0.2a/resources/themes/lib/utils.rb

require 'sass/script/functions'

module ExtRailsShim
  module SassExtensions
    module Functions
      module Utils
        def parsebox(list, n)
          assert_type n, :Number
          if !n.int?
            raise ArgumentError.new("List index #{n} must be an integer")
          elsif n.to_i < 1
            raise ArgumentError.new("List index #{n} must be greater than or equal to 1")
          elsif n.to_i > 4
            raise ArgumentError.new("A box string can't contain more then 4")
          end

          new_list = list.clone.to_a
          size = new_list.size
                      
          if n.to_i >= size
            if size == 1
              new_list[1] = new_list[0]
              new_list[2] = new_list[0]
              new_list[3] = new_list[0]
            elsif size == 2
              new_list[2] = new_list[0]
              new_list[3] = new_list[1]
            elsif size == 3
              new_list[3] = new_list[1]
            end
          end
          
          new_list.to_a[n.to_i - 1]
        end
        
        def parseint(value)
          Sass::Script::Number.new(value.to_i)
        end
        
        # Returns a background-image property for a specified images for the theme
        # NOTE: relative is ignored.
        def theme_image(theme, path, without_url = false, relative = false)
          path = path.value
          theme = theme.value
          without_url = (without_url.class == FalseClass) ? without_url : without_url.value
          
          asset_path = '/assets/ext4'
          image_path = File.join(asset_path, theme, path)
          
          url = without_url ? image_path : "url('#{image_path}')"
          Sass::Script::String.new(url)
        end

        def theme_image_exists(path)
          where_to_look = path.value.gsub('/assets/ext4', 'vendor/assets/images/ext4')
          result = where_to_look && FileTest.exists?("#{where_to_look}")
          return Sass::Script::Bool.new(result)
        end
      end
    end
  end
end

module Sass::Script::Functions
  include ExtRailsShim::SassExtensions::Functions::Utils
end
