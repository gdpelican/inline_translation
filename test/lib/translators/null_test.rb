require 'test_helper'
require 'inline_translation/translators/base'
require 'inline_translation/translators/null'

class NullTest < UnitTest
  describe InlineTranslation::Translators::Null do

    let(:translator_class) { InlineTranslation::Translators::Null }
    let(:translator) { translator_class.new }

    it "returns ready as true" do
      assert translator_class.ready?
    end

    it "returns nil as a translation" do
      assert_nil translator.translate("anything")
    end

  end
end
