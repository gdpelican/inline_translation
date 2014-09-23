require 'test_helper'
require 'babbel/concerns/is_translatable'
require 'babbel/concerns/translatable'
require 'byebug'

class IsTranslatableTest < Rails::Generators::TestCase
  tests Babbel::IsTranslatable
  setup_destination
  setup_model

  test "defines a translatable_fields class method" do
    TestModel.class_eval "is_translatable on: :column"
    assert_equal TestModel.translatable_fields, [:column]
  end

  test "defines a custom get_instance class method" do
    TestModel.class_eval "is_translatable on: :column"
    model = TestModel.create
    assert_equal TestModel.get_instance(model.id), model
  end

  test "defines a get_instance class method as :find by default" do
    TestModel.define_singleton_method(:find_alt) { |id| "found #{id}!" }
    TestModel.class_eval "is_translatable on: :column, load_via: :find_alt"
    assert_equal TestModel.get_instance(42), "found 42!"
  end

  test "defines an id_field method as :id by default" do
    TestModel.class_eval "is_translatable on: :column"
    model = TestModel.new id: 42
    assert_equal model.id, model.id_field
  end

  test "defines a custom id_field method" do
    TestModel.class_eval "is_translatable on: :column, id_field: :id_alt"
    model = TestModel.new id_alt: 42
    assert_equal model.id_alt, model.id_field
  end

  test "defines a language_field method as :language by default" do
    TestModel.class_eval "is_translatable on: :column"
    model = TestModel.new language: :en
    assert_equal model.language, model.language_field
  end

  test "defines a custom language_field method" do
    TestModel.class_eval "is_translatable on: :column, language_field: :language_alt"
    model = TestModel.new language_alt: :en
    assert_equal model.language_alt, model.language_field
  end

end