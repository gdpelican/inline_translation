module Babbel
  module Translators
    class Base
      attr_reader :translator

      def ready?
        false
      end

      def can_translate?(translatable, field, to)
        ready? &&
        to.present? &&
        translatable.respond_to?(field) &&
        translatable.language_field.present? &&
        translatable.language_field.to_s != to.to_s &&
        translatable.translations.where(field: field, language: to).empty?
      end

      def translate(text, from: nil, to: I18n.locale)
        raise NotImplementedError.new
      end

    end
  end
end