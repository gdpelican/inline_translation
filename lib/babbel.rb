require 'active_support'

module Babbel
  extend ActiveSupport::Autoload

  cattr_accessor :translator

  module Concerns
    autoload :ActsAsTranslatable, 'babbel/concerns/acts_as_translatable'
    autoload :Translatable,       'babbel/concerns/translatable'
  end

  module Controllers
    autoload :TranslationsController, 'controllers/translations_controller'
  end

  module Generators
    autoload :InstallGenerator,   'babbel/generators/install/install_generator'
  end

  module Helpers
    autoload :TranslationsHelper, 'babbel/helpers/translations_helper'
  end

  module Models
    autoload :Translation,        'babbel/models/translation'
  end

  module Services
    autoload :TranslationService, 'babbel/services/translation_service'
  end

  module Translators
    autoload :Base,               'babbel/translators/base'
    autoload :Bing,               'babbel/translators/bing'
    autoload :Null,               'babbel/translators/null'
  end

  self.translator ||= Translators::Null.new

end