require 'test_helper'
require 'babbel/concerns/translatable'

class TranslatableTest < Rails::Generators::TestCase
  tests Babbel::Translatable
  setup_destination
  setup_model

  TestModel.class_eval "include Babbel::Translatable"

  test "has many translations" do
    model = TestModel.new
    assert_equal model.translations, []
  end

  test "destroys translations after update" do
  end

end