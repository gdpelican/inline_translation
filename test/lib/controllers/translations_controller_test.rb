require 'test_helper'

class TranslationsControllerTest < ControllerTest
  describe Babbel::Controllers::TranslationsController do
    setup_model :controller_model
    let(:model) { ControllerModel.new column1: "test text", column2: "more text" }
    let(:service) { Babbel::Services::TranslationService.new }

    setup do
      @controller ||= Babbel::Controllers::TranslationsController.new
    end

    describe "POST create" do
      it "can create a translation" do
        params = { translatable_id: model.id,
                   translatable_type: "ControllerModel",
                   field: :column1,
                   to: :fr }
        service.stubs(:translate).returns("A french translation")

        post :create, params

        created = Translation.last
        assert_equal created.translatable, model
        assert_equal created.field, :column1
        assert_equal created.language, fr
        assert_equal created.translation, "A french translation" 
      end
    end
  end
end
