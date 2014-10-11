require 'test_helper'

class BabbelTest < UnitTest
  describe "Babbel version" do
    it "return the correct version" do
      Babbel::VERSION.must_equal '0.0.1'
    end
  end
end
