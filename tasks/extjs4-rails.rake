# based on https://github.com/sakuro/ext_rails_shim/blob/master/lib/tasks/ext_rails_shim_tasks.rake @e6da6188d91eb201a4cc7ed952e827bc7d63bac9

namespace :'extjs4-rails' do
  ASSETS_DIR      = 'vendor/assets'
  IMAGES_DIR      = ASSETS_DIR + '/images/extjs4-rails'
  JAVASCRIPTS_DIR = ASSETS_DIR + '/javascripts/extjs4-rails'
  STYLESHEETS_DIR = ASSETS_DIR + '/stylesheets/extjs4-rails'

  THEME_NAME = ENV['EXTJS_THEME'] || 'classic'
  EXTJS_DIR  = ENV.has_key?('EXTJS_DIR') ? File.expand_path(ENV['EXTJS_DIR']) : nil
  THEME_DIR  = "#{EXTJS_DIR}/packages/ext-theme-#{THEME_NAME}"

  directory IMAGES_DIR
  directory JAVASCRIPTS_DIR
  directory STYLESHEETS_DIR

  desc 'Install Ext JS scripts and themes'
  task :install => %w(install:clean install:javascripts install:themes)

  namespace :install do
    task clean: ASSETS_DIR do
      rm_rf ASSETS_DIR
    end

    task :extjs_dir do
      raise 'EXTJS_DIR is not set.' unless EXTJS_DIR
      raise 'EXTJS_DIR is not a directory.' unless FileTest.directory?(EXTJS_DIR)
      raise "EXTJS theme directory '#{THEME_DIR}' does not exist." unless FileTest.directory?(THEME_DIR)
    end

    task javascripts: JAVASCRIPTS_DIR do
      script_files = FileList["#{EXTJS_DIR}/*.js"]
      cp script_files, JAVASCRIPTS_DIR
    end

    task themes: %w(images stylesheets)

    task images: IMAGES_DIR do
      images_DIRs = FileList["#{EXTJS_DIR}/resources/themes/images/default/*"]
      cp_r images_DIRs, IMAGES_DIR

      images_DIRs = FileList["#{THEME_DIR}/build/resources/images/*"]
      cp_r images_DIRs, IMAGES_DIR
    end

    task stylesheets: STYLESHEETS_DIR do # Actually 'images' task is another prerequisite, too.
      compass_command_line = %w(compass compile)
      compass_init_path = File.join(File.dirname(__FILE__), '../config/compass_init.rb')
      compass_command_line << '--config' << compass_init_path
      compass_command_line << '--sass-dir' << File.join(EXTJS_DIR, "packages/ext-theme-#{THEME_NAME}/build")
      compass_command_line << '--css-dir' << STYLESHEETS_DIR
      compass_command_line << '--output-style' << 'compressed'
      compass_command_line << '--trace'
      compass_command_line << '--force'
      sh *compass_command_line

      Dir.glob("#{STYLESHEETS_DIR}/*-debug.css").each {|file| File.rename(file, file.gsub('-debug', '')) }
    end
  end
end

Rake.application.tasks_in_scope(Rake::Scope.new("extjs4-rails:install")).each do |t|
  next if t.name == 'extjs4-rails:install:extjs_dir'
  t.prerequisites.unshift 'extjs4-rails:install:extjs_dir'
end
