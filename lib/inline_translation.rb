require 'active_support'
require 'inline_translation/engine'

module InlineTranslation
  extend ActiveSupport::Autoload

  cattr_accessor :translator

  module Concerns
    autoload :ActsAsTranslatable, 'inline_translation/concerns/acts_as_translatable'
    autoload :Translatable,       'inline_translation/concerns/translatable'
  end

  module Controllers
    autoload :TranslationsController, 'controllers/translations_controller'
  end

  module Generators
    autoload :InstallGenerator,   'generators/install/install_generator'
  end

  module Helpers
    autoload :TranslationsHelper, 'inline_translation/helpers/translations_helper'
  end

  module Models
    autoload :Translation,        'inline_translation/models/translation'
  end

  module Services
    autoload :TranslationService, 'inline_translation/services/translation_service'
  end

  module Translators
    autoload :Base,               'inline_translation/translators/base'
    autoload :Bing,               'inline_translation/translators/bing'
    autoload :Null,               'inline_translation/translators/null'
  end

  self.translator ||= Translators::Null

end
