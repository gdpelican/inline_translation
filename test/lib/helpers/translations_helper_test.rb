require 'test_helper'

class TranslationsHelperTest < UnitTest
  include Babbel::Helpers::TranslationsHelper
  include Rails.application.routes.url_helpers

  setup_model :helper_model

  let(:model) { HelperModel.new column1: 'a value', language: :en }

  before do
    I18n.locale = :fr
  end

  describe ".translate_link_for" do
    it "returns a link with another locale set" do
      assert_match /a href/, translate_link_for(model)
    end

    it "returns a link with a specified locale" do
      I18n.locale = :en
      assert_match /a href/, translate_link_for(model, to: :fr)
    end

    it "defaults to 'Translate' for link text" do
      assert_match /Translate/, translate_link_for(model)
    end
 
    it "accepts a text parameter" do
      assert_match /Other text/, translate_link_for(model, text: 'Other text')
    end

    it "does not return a link when locale is the same" do
      I18n.locale = :en
      refute translate_link_for(model)
    end

    it "does not return a link when specified locale is the same" do
      refute translate_link_for(model, to: :en)
    end
  end

  describe ".translated_element_for" do
    it "returns an span with a language class" do
      assert_match /to-fr/, translated_element_for(model, :column1)
    end

    it "returns a span with a field class" do
      assert_match /column1-translated/, translated_element_for(model, :column1)
    end

    it "returns a span with a babbel class" do
      assert_match /babbel-translated/, translated_element_for(model, :column1)
    end

    it "accepts an element parameter" do
      assert_match /<div/, translated_element_for(model, :column1, element: :div)
    end
  end

end
