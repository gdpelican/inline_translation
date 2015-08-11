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

        assert_equal json.length, translatable.translations.size
        fields =             json.map { |t| t['field'] }
        translatable_ids =   json.map { |t| t['translatable_id'] }
        translatable_types = json.map { |t| t['translatable_type'] }

        assert_includes fields, 'column1'
        assert_includes fields, 'column2'
        assert_includes translatable_ids, translatable.id
        assert_includes translatable_types, 'ControllerModel'
      end

      it "returns the translation for successful translation for JS" do
        # TODO: stub out the call to render, which errors because we don't have a translations#create view
        skip "Stub out render call so there's no 'cannot find translations#create view' error"
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
