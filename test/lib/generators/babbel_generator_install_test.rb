require 'test_helper'
require 'generators/inline_translation/install/install_generator'

class InlineTranslationGeneratorInstallTest < Rails::Generators::TestCase
  tests InlineTranslation::InstallGenerator
  setup_destination

  test "generates a migration file" do
    run_generator
    assert_migration "db/migrate/add_inline_translations.rb"
  end

  test "generates an initializer file" do
    run_generator
    assert_file "config/initializers/inline_translation.rb"
  end

  test "generates a create js view file" do
    run_generator
    assert_file "app/views/translations/create.js.erb"
  end
end
