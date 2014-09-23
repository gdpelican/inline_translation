require 'test_helper'
require 'babbel'

class BabbelTest < Rails::Generators::TestCase
  tests Babbel
  setup_destination

  test "returns the correct version" do
    assert_equal Babbel::VERSION, '0.0.1'
  end
end
