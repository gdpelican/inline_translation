module Babbel
  module Translators
  	class Base

      def ready?
        false
      end

  	  def can_translate?(translatable, from: I18n.locale)
        ready? &&
        translatable.language_field.present? &&
        translatable.language_field != from
      end

      def translate(text, from: nil, to: I18n.locale)
        raise NotImplementedError.new
      end

  	end
  end
end