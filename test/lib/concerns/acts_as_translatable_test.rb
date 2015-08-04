require 'test_helper'

class ActsAsTranslatableTest < UnitTest
  describe InlineTranslation::Concerns::ActsAsTranslatable do

    before do
      setup_model :concern_model
      ConcernModel.define_singleton_method(:find_alt) { |id| "found #{id}!" }
    end

    it "includes Translatable" do
      ConcernModel.class_eval "acts_as_translatable on: [:column1, :column2]"
      assert ConcernModel.included_modules.include?(InlineTranslation::Concerns::Translatable)
    end

    it "defines a translatable_fields class method" do
      ConcernModel.class_eval "acts_as_translatable on: [:column1, :column2]"
      assert_equal ConcernModel.translatable_fields, [:column1, :column2]
    end

    it "defines a single translatable_field correctly" do
      ConcernModel.class_eval "acts_as_translatable on: :column1"
      assert_equal ConcernModel.translatable_fields, [:column1]
    end

    it "defines a custom get_instance class method" do
      ConcernModel.class_eval "acts_as_translatable on: [:column1, :column2], load_via: :find_alt"
      assert_equal ConcernModel.get_instance(42), ConcernModel.find_alt(42)
    end

    it "defines a get_instance class method as :find by default" do
      ConcernModel.class_eval "acts_as_translatable on: [:column1, :column2]"
      model = ConcernModel.create
      assert_equal ConcernModel.get_instance(model.id), ConcernModel.find(model.id)
    end

    it "defines an id_field method as :id by default" do
      ConcernModel.class_eval "acts_as_translatable on: [:column1, :column2]"
      model = ConcernModel.new id: 42
      assert_equal model.id_field, model.id
    end

    it "defines a custom id_field method" do
      ConcernModel.class_eval "acts_as_translatable on: [:column1, :column2], id_field: :id_alt"
      model = ConcernModel.new id_alt: 42
      assert_equal model.id_field, model.id_alt
    end

    it "defines a language_field method as :language by default" do
      ConcernModel.class_eval "acts_as_translatable on: [:column1, :column2]"
      model = ConcernModel.new language: :en
      assert_equal model.language_field, model.language
    end

    it "defines a custom language_field method" do
      ConcernModel.class_eval "acts_as_translatable on: [:column1, :column2], language_field: :language_alt"
      model = ConcernModel.new language_alt: :en
      assert_equal model.language_field, model.language_alt
    end
  end

end