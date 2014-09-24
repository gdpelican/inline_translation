require 'test_helper'
require 'babbel/translators/base'

class BaseTest < MiniTest::Spec
  describe Babbel::Translators::Base do

    let(:translator) { Babbel::Translators::Base.new }

    it "returns false on ready?" do
      refute translator.ready?
    end

    it "returns false on can_translate?" do
      refute translator.can_translate? nil
    end
    
    it "raises an error on translate" do
      assert_raises NotImplementedError do translator.translate(nil) end
    end

  end
end
