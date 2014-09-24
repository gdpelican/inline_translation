require 'test_helper'
require 'babbel/controllers/translations_controller'

class TranslationsControllerTest < MiniTest::Spec
  describe Babbel::Controllers::TranslationsController do
    setup_model :controller_model
    let(:model) { ControllerModel.new column1: "test text", column2: "more text" }

    it "creates translations with valid parameters" do
      post :create, translatable_id: model.id, translatable_type: "ControllerModel", to: "en"
      byebug
      assert_response :success
    end

    it "returns unprocessable entity with invalid parameters" do
    
    end
  end
end
