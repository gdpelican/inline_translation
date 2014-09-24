require 'test_helper'
require 'babbel/concerns/translatable'

require 'byebug'

class TranslatableTest < MiniTest::Spec
  describe Babbel::Concerns::Translatable do

    before do
      setup_model :concern_model
      include_translatable ConcernModel
    end

    it "has_many translations" do
    end

    it "destroys translations after update" do
    end

  end

end