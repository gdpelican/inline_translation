require 'test_helper'
require 'inline_translation/models/translation'

class TranslationTest < UnitTest
  describe InlineTranslation::Models::Translation do

    setup_model :model_class
    let(:translation) { InlineTranslation::Models::Translation.new translatable: ModelClass.new,
                                                        language: :en,
                                                        field: :field_name,
                                                        translation: :translation }

    it "should be valid when all fields are present" do
      assert translation.valid?
    end

    it "should have a translatable" do
      assert_respond_to translation, :translatable
      assert_instance_of ModelClass, translation.translatable
    end

    it "should require a translatable" do
      translation.translatable = nil
      refute translation.valid?
    end

    it "should have a language" do
      assert_equal translation.language, :en
    end

    it "should require a language" do
      translation.language = nil
      refute translation.valid?
    end

    it "should have a field name" do
      assert_equal translation.field, :field_name
    end

    it "should require a field name" do
      translation.field = nil
      refute translation.valid?
    end

    it "should have a translation" do
      assert_equal translation.translation, :translation
    end

    it "should require a translation" do
      translation.translation = nil
      refute translation.valid?
    end

  end
end
