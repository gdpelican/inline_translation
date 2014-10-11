require 'action_controller'

class ControllerTest < UnitTest
  include ActionController::TestCase::Behavior
  before { @routes = Rails.application.routes }
end