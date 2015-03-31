require 'font-awesome-rails'
require 'jquery-rails'
require 'jquery-ui-rails'
require 'kaminari'
require 'nested_form'
require 'rails'
require 'rails_admin'
require 'remotipart'
require 'safe_yaml'
require 'express_admin'

SafeYAML::OPTIONS[:suppress_warnings] = true
SafeYAML::OPTIONS[:default_mode] = :unsafe

module RailsAdmin
  class Engine < Rails::Engine
    isolate_namespace RailsAdmin
    include ::ExpressAdmin::Menu::Loader

    initializer :assets do |config|
      engine_assets_path = File.join(File.dirname(__FILE__), '..', '..', 'app', 'assets')
      all_assets = Dir.glob File.join(engine_assets_path, 'stylesheets', '**', '*.css*')
      all_assets += Dir.glob File.join(engine_assets_path, 'javascripts', '**', '*.js*')
      all_assets.each {|path| path.gsub!("#{engine_assets_path}/stylesheets/", '')}
      all_assets.each {|path| path.gsub!("#{engine_assets_path}/javascripts/", '')}
      Rails.application.config.assets.precompile += all_assets
    end

    RailsAdmin::Engine.config.rails_admin_mount_point = '/admin/manage'

    initializer 'RailsAdmin precompile hook', group: :all do |app|
      app.config.assets.precompile += %w(
        rails_admin/rails_admin.js
        rails_admin/rails_admin.css
        rails_admin/jquery.colorpicker.js
        rails_admin/jquery.colorpicker.css
      )
    end

    rake_tasks do
      Dir[File.join(File.dirname(__FILE__), '../tasks/*.rake')].each { |f| load f }
    end

    def self.express_admin_menu
      RecursiveOpenStruct.new({main: {title: 'Admin', path: 'rails_admin.dashboard_path'}})
    end

  end
end
