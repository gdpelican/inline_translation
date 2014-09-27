require 'test_helper'

class TranslationsControllerTest < MiniTest::Spec
  describe Babbel::Controllers::TranslationsController do
    setup_model :controller_model
    let(:model) { ControllerModel.new column1: "test text", column2: "more text" }

    it "creates translations with valid parameters" do

    end

    it "returns unprocessable entity with invalid parameters" do
    
    end
  end
end
