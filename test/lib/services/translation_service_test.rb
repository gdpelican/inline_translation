require 'test_helper'
require 'babbel/services/translation_service'
require 'babbel/models/translation'

class BabbelTranslationServiceTest < UnitTest
  setup_model :service_model
  setup_translation

  let(:translator_class) { Babbel::Translators::Base }
  let(:translator)   { translator_class.new }
  let(:service)      { Babbel::Services::TranslationService.new(translator_class) }
  let(:translatable) { ServiceModel.new column1: "translatable text", column2: "more text", language: :en }

  before do
    ServiceModel.class_eval "acts_as_translatable on: [:column1, :column2]"
    include_translatable ServiceModel
    translator_class.stubs(:ready?).returns(true)
    translator.stubs(:can_translate?).returns(true)
    translator.stubs(:translate).returns(true)
  end

  describe "initialize" do
    it "sets a translator object on initialize" do
      assert_equal service.translator.class, translator.class
    end
    it "raises an error on initialize if translator is not ready" do
      translator_class.stubs(:ready?).returns(false)
      ->{ service }.must_raise Babbel::Services::InvalidTranslatorError
    end
  end

  describe "invalid translator error" do
    it "has an error message" do
      assert_match /Unable to instantiate translator/, Babbel::Services::InvalidTranslatorError.new.to_s
    end
  end

  describe "translate" do
    it "returns the results of translate!" do
      service.stubs(:translate!).returns("translation result")
      assert_equal service.translate(translatable), "translation result"
    end
  end

  describe "translate!" do
    it "builds all translations using translate_field" do
      service.translate!(translatable)
      assert_equal translatable.translations.size, 2
    end

    it "does not build an invalid translation" do
      translator.stubs(:can_translate?).returns(false)
      service.translate!(translatable)
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
