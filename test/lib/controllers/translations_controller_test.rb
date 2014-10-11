require 'test_helper'

class TranslationsControllerTest < ControllerTest
  describe Babbel::Controllers::TranslationsController do
    setup_model :controller_model
    let(:model) { ControllerModel.new column1: "test text", column2: "more text" }
  end
end
