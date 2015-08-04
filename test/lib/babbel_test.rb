require 'test_helper'

class InlineTranslationTest < UnitTest
  describe "InlineTranslation version" do
    it "return the correct version" do
      InlineTranslation::VERSION.must_equal '0.0.1'
    end
  end
end
