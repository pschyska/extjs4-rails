# based on https://github.com/sakuro/ext_rails_shim/blob/master/lib/tasks/ext_rails_shim_tasks.rake @e6da6188d91eb201a4cc7ed952e827bc7d63bac9

namespace :'extjs-rails' do
  IMAGES_DIR = 'vendor/assets/images/ext4'
  JAVASCRIPTS_DIR = 'vendor/assets/javascripts/ext4'
  STYLESHEETS_DIR = 'vendor/assets/stylesheets/ext4'

  directory IMAGES_DIR
  directory JAVASCRIPTS_DIR
  directory STYLESHEETS_DIR

  desc 'Install Ext.js scripts and themes'
  task :install => %w(install:javascripts install:themes)


  namespace :install do
    task :ext4_dir do
      raise 'EXT4_DIR is not set.' unless ENV.has_key?('EXT4_DIR')
      raise 'EXT4_DIR is not a directory.' unless FileTest.directory?(ENV['EXT4_DIR'])
    end

    task javascripts: JAVASCRIPTS_DIR do
      script_files = FileList["#{ENV['EXT4_DIR']}/*.js"]
      cp script_files, JAVASCRIPTS_DIR
    end

    task themes: %w(images stylesheets)

    task images: IMAGES_DIR do
      images_DIRs = FileList["#{ENV['EXT4_DIR']}/resources/themes/images/*"]
      cp_r images_DIRs, IMAGES_DIR
    end

    task stylesheets: STYLESHEETS_DIR do # Actually 'images' task is another prerequisite, too.
      compass_command_line = %w(compass compile)
      compass_init_path = File.join(File.dirname(__FILE__), '../config/compass_init.rb')
      compass_command_line << '--config' << compass_init_path
      compass_command_line << '--sass-dir' << File.join(ENV['EXT4_DIR'], 'resources/sass')
      compass_command_line << '--css-dir' << STYLESHEETS_DIR
      compass_command_line << '--output-style' << 'compressed'
      compass_command_line << '--load' << File.join(ENV['EXT4_DIR'], 'resources/themes')
      sh *compass_command_line
    end
  end
end

Rake.application.tasks_in_scope(%w(extjs-rails install)).each do |t|
  next if t.name == 'extjs-rails:install:ext4_dir'
  t.prerequisites.unshift 'extjs-rails:install:ext4_dir'
end
