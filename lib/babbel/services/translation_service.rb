module Babbel
  module Services
    class TranslationService
      def initialize(translator)
        raise InvalidTranslatorError.new unless translator.ready?
        @translator = translator
      end

      def translate(translatable, to: I18n.locale)
        model.class.translatable_fields.map { |field| translate_field(translatable, field, to: to) }
        translatable.save
      end

      def translate_field(translatable, field, to: I18n.locale)
        translatable.translations.build(
          field: field,
          language: to,
          translation: @translator.translate(translatable.send(field), from: translatable.language_field, to: to)
        ) if perform_translation?
      end

      private

      def perform_translation?(translatable, field, to)
        @translator.can_translate?(translatable) && 
        translatable.translations.where(field: field, language: to).empty?
      end

    end

    class InvalidTranslatorError < StandardError
      def to_s
        "Unable to instantiate translator: Please ensure that the appropriate ENV variables are set"
      end
    end
  end
end
