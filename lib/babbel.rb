require 'active_support'

module Babbel
  extend ActiveSupport::Autoload

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

  module Models
    autoload :Translation,        'babbel/models/translation'
  end

  module Services
    autoload :TranslationService, 'babbel/services/translation_service'
  end

  module Translators
    autoload :Base,               'babbel/translators/base'
    autoload :Bing,               'babbel/translators/bing'
  end

  def self.translator=(translator)
    @@translator = translator
  end

  def self.translator
    @@translator
  end
end