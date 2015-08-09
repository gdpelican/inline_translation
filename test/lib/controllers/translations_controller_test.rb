require 'test_helper'

class TranslationsControllerTest < ControllerTest
  describe InlineTranslation::Controllers::TranslationsController do
    setup_model :controller_model
    let(:service) { InlineTranslation::Services::TranslationService.new }
    let(:translatable) { ControllerModel.create }
    let(:translation_result) { { column1: 'A translation!', column2: 'A translation!' } }

    setup do
      ControllerModel.class_eval "acts_as_translatable on: [:column1, :column2]"
      @controller ||= InlineTranslation::Controllers::TranslationsController.new
      translatable
    end

    describe "POST create" do
      it "returns the translation for successful translation for JSON" do
        InlineTranslation.stubs(:ready?).returns(true)
        InlineTranslation::Translators::Null.any_instance.stubs(:can_translate?).returns(true)
        InlineTranslation::Translators::Null.any_instance.stubs(:translate).returns("A translation!")
        post :create, translatable_type: "ControllerModel", translatable_id: translatable.id, format: :json

        assert_equal response.status, 200
        json = JSON.parse(response.body)

        assert_equal json['translations']['column1'], translation_result[:column1]
        assert_equal json['translations']['column2'], translation_result[:column2]
        assert_equal json['translatable_id'], translatable.id
        assert_equal json['translatable_type'], 'ControllerModel'
      end

      it "returns the translation for successful translation for JS" do
        InlineTranslation.stubs(:ready?).returns(true)
        InlineTranslation::Translators::Null.any_instance.stubs(:can_translate?).returns(true)
        InlineTranslation::Translators::Null.any_instance.stubs(:translate).returns("A translation!")
        ActionView::Renderer.any_instance.stubs(:render).with('translations/create').returns('wark')
        post :create, translatable_type: "ControllerModel", translatable_id: translatable.id, format: :js

        assert_equal response.status, 200
      end


      it "returns unprocessable entity for unsuccessful translation" do
        InlineTranslation::Services::TranslationService.any_instance.stubs(:translate).returns(false)
        post :create, translatable_type: "ControllerModel", translatable_id: translatable.id, format: :json
        assert_equal response.status, 422
      end

      it "returns unprocessable entity when translatable_type is not defined" do
        InlineTranslation::Services::TranslationService.any_instance.stubs(:translate).returns(false)
        post :create, format: :json
        assert_equal response.status, 422
      end
    end
  end
end
