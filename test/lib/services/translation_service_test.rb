require 'test_helper'
require 'babbel/services/translation_service'

class BabbelTest < Rails::Generators::TestCase
  tests Babbel::Services::TranslationService
  setup_destination

end
