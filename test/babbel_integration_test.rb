require 'test_helper'
class InlineTranslationIntegrationTest < IntegrationTest
  describe InlineTranslation do
    setup_model :integration_model

    let(:model) { IntegrationModel.create! column1: "column one", column2: "column2", language: :en }

    setup do
      @controller ||= InlineTranslation::Controllers::TranslationsController.new
      IntegrationModel.acts_as_translatable on: [:column1, :column2]
      InlineTranslation::Translators::Null.stubs(:ready?).returns(true)
      InlineTranslation::Translators::Null.any_instance.stubs(:translate).returns("this is a translation", "this is another translation")
    end

    describe "creating translations" do
      it "can create translations" do
        post :create, translatable_type: "IntegrationModel", translatable_id: model.id, to: :fr, format: :json

        created = Translation.where(translatable_type: "IntegrationModel")

        assert_equal created.where(translatable_id: model.id).size, 2
        assert_equal created.where(language: :fr).size, 2
        assert_equal created.where(translatable_type: "IntegrationModel").size, 2
        assert_equal created.where(translation: "this is a translation").size, 1
        assert_equal created.where(translation: "this is another translation").size, 1


        before_count = Translation.count
        post :create, translatable_type: "IntegrationModel", translatable_id: model.id, to: :fr, format: :json
        assert_equal Translation.count, before_count
      end
    end
  end
end
