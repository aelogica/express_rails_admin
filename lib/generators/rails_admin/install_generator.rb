module RailsAdmin
  class InstallGenerator < Rails::Generators::Base
    desc 'mount rails_admin engine'
    def install
      route "mount RailsAdmin::Engine, at: RailsAdmin::Engine.config.rails_admin_mount_point"
    end
  end
end
