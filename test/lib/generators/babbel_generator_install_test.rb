require 'test_helper'
require 'generators/babbel/install/install_generator'

class BabbelGeneratorInstallTest < Rails::Generators::TestCase
  tests Babbel::InstallGenerator
  setup_destination

  test "generates a migration file" do
    run_generator
    assert_migration "db/migrate/add_babbel_translations.rb"
  end

  test "generates an initializer file" do
    run_generator
    assert_file "config/initializers/babbel.rb"
  end
end
