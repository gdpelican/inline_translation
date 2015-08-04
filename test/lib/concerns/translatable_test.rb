require 'test_helper'

class TranslatableTest < UnitTest
  describe InlineTranslation::Concerns::Translatable do

    let(:model) { ConcernModel.create column1: "test text" }

    before do
      setup_model :concern_model
      include_translatable ConcernModel
    end

    it "has_many translations" do
      assert_respond_to model, :translations
      assert_instance_of InlineTranslation::Models::Translation, model.translations.build
    end

    it "destroys translations after update" do
      model.translations.build language: :en, field: :column1, translation: "test translation"
      model.save
      assert_equal model.reload.translations.size, 1

      model.update! column1: "changed text"
      model.save

      assert_equal model.reload.translations.size, 0
    end

  end

end