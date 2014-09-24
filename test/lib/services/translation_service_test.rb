require 'test_helper'
require 'babbel/services/translation_service'
require 'babbel/models/translation'

class BabbelTranslationServiceTest < MiniTest::Spec
  setup_model :service_model
  setup_translation

  let(:translator)   { Babbel::Translators::Base.new }
  let(:service)      { Babbel::Services::TranslationService.new(translator) }
  let(:translatable) { ServiceModel.new column1: "translatable text", column2: "more text", language: :en }

  before do
    ServiceModel.class_eval "is_translatable on: [:column1, :column2]"
    include_translatable ServiceModel
    translator.stubs(:ready?).returns(true)
    translator.stubs(:can_translate?).returns(true)
    translator.stubs(:translate).returns(true)
  end

  describe "initialize" do
    it "sets a translator object on initialize" do
      assert_equal service.translator, translator
    end
    it "raises an error on initialize if translator is not ready" do
      translator.stubs(:ready?).returns(false)
      ->{ service }.must_raise Babbel::Services::InvalidTranslatorError
    end
  end

  describe "translate" do
    it "builds all translations using translate_field" do
      service.translate(translatable)
      assert_equal translatable.translations.size, 2
    end

    it "does not build an invalid translation" do
      translator.stubs(:can_translate?).returns(false)
      assert_equal translatable.translations.size, 0
    end
  end

  describe "translate_field" do
    it "builds a translation with translate_field" do
      service.translate_field(translatable, :column1)
      assert_equal translatable.translations.size, 1
    end
    it "does not build an invalid translation" do
      translator.stubs(:can_translate?).returns(false)
      service.translate_field(translatable, :column1)
      assert_equal translatable.translations.size, 0      
    end
  end

end
