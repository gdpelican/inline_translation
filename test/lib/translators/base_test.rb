require 'test_helper'
require 'babbel/translators/base'

class BaseTest < MiniTest::Spec
  describe Babbel::Translators::Base do

    let(:translator) { Babbel::Translators::Base.new }

    it "raises an error on ready?" do
      assert_raises NotImplementedError do translator.ready? end
    end

    it "raises an error on translate" do
      assert_raises NotImplementedError do translator.translate(nil) end
    end

    it "raises an error on can_translate?" do
      assert_raises NotImplementedError do translator.can_translate?(nil) end
    end
  end
end
