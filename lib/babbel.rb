require 'active_support'

module Babbel
  extend ActiveSupport::Autoload

  autoload :TranslationsController

  module Concerns
    autoload :IsTranslatable,     'babbel/concerns/is_translatable'
    autoload :Translatable,       'babbel/concerns/translatable'
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