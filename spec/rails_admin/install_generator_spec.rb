require 'spec_helper'
require 'generators/rails_admin/install_generator'

describe RailsAdmin::InstallGenerator, type: :generator do
  destination File.expand_path('../../dummy_app/tmp/generator', __FILE__)
  arguments ['admin']

  before do
    prepare_destination
  end

  it 'mounts RailsAdmin as Engine and generates RailsAdmin Initializer' do
    expect_any_instance_of(generator_class).to receive(:route).
      with("mount RailsAdmin::Engine, at: RailsAdmin::Engine.config.rails_admin_mount_point")
    capture(:stdout) do
      generator.invoke('install')
    end
  end
end
