require 'test_helper'

class TranslationsControllerTest < ControllerTest
  describe Babbel::Controllers::TranslationsController do
    setup_model :controller_model
    let(:service) { Babbel::Services::TranslationService.new }

    setup do
      @controller ||= Babbel::Controllers::TranslationsController.new
    end

    describe "POST create" do
      it "returns ok for successful translation" do
        Babbel::Services::TranslationService.any_instance.stubs(:translate).returns(:true)
        post :create, translatable_type: "ControllerModel"
        assert_equal response.status, 200
      end

      it "returns unprocessable entity for unsuccessful translation" do
        Babbel::Services::TranslationService.any_instance.stubs(:translate).returns(false)
        post :create
        assert_equal response.status, 422
      end

      it "returns unprocessable entity when translatable_type is not defined" do
        Babbel::Services::TranslationService.any_instance.stubs(:translate).returns(false)
        post :create
        assert_equal response.status, 422
      end
    end
  end
end
