require 'test_helper'
require 'babbel/translators/base'
require 'babbel/translators/bing'
require 'bing_translator'

class BingTest < UnitTest
  describe Babbel::Translators::Bing do

    let(:translator) { Babbel::Translators::Bing.new }

    before do
      setup_bing_translator_env
    end

    it "initializes a BingTranslator" do 
      assert_instance_of BingTranslator, translator.translator
    end

    it "returns ready if ENV variables are set" do
      assert translator.ready?
    end

    it "returns not ready if app id is not set" do
      ENV['BING_TRANSLATOR_APP_ID'] = nil
      refute translator.ready?
    end

    it "returns not ready if secret is not set" do
      ENV['BING_TRANSLATOR_SECRET'] = nil
      refute translator.ready?
    end

    it "can translate a translatable" do
      translator.translator.stubs(:translate).returns("translation")
      assert_equal translator.translate("original"), "translation"
    end
  end
end
