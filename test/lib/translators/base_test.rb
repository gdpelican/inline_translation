require 'test_helper'
require 'babbel/translators/base'

class BaseTest < UnitTest
  describe Babbel::Translators::Base do
    setup_model :translator_model

    let(:translator_class) { Babbel::Translators::Base }
    let(:translator) { translator_class.new }
    let(:translatable) { TranslatorModel.new column1: "column one", language: :en }

    setup do
      TranslatorModel.acts_as_translatable on: :column1
    end

    it "returns false on ready?" do
      refute translator_class.ready?
    end

    describe ".can_translate?" do

      it "returns false if the translator is not ready" do
        refute translator.can_translate? translatable, :column1, :fr
      end

      it "returns false if 'to' is not set" do
        translator.stubs(:ready?).returns(:true)
        refute translator.can_translate? translatable, :column1, nil
      end

      it "returns false if translatable's language is not set" do
        translator.stubs(:ready?).returns(:true)
        translatable.language = nil
        refute translator.can_translate? translatable, :column1, :fr
      end

      it "returns false if the from and to language are the same" do
        translator.stubs(:ready?).returns(:true)
        refute translator.can_translate? translatable, :column1, :en
      end

      it "returns false if a translation already exists" do
        translator.stubs(:ready?).returns(:true)
        translatable.save
        translatable.translations.create field: :column1, language: :fr
        refute translator.can_translate? translatable, :column1, :fr
      end

      it "returns false if the field is not found on translatable" do
        translator_class.stubs(:ready?).returns(:true)
        refute translator.can_translate? translatable, :notacolumn, :fr
      end

      it "returns true otherwise" do
        translator_class.stubs(:ready?).returns(:true)
        assert translator.can_translate? translatable, :column1, :fr
      end
    end

    it "raises an error on translate" do
      assert_raises NotImplementedError do translator.translate(nil) end
    end

  end
end
