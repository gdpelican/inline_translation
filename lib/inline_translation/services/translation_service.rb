module InlineTranslation
  module Services
    class TranslationService
      attr_reader :translator

      def initialize(translator_class = InlineTranslation.translator)
        raise InvalidTranslatorError.new unless translator_class.ready?
        @translator = translator_class.new
      end

      def translate(translatable, to: I18n.locale)
        translate!(translatable, to: to) rescue false
      end

      def translate!(translatable, to: I18n.locale)
        translatable.class.translatable_fields.map { |field| translate_field(translatable, field, to: to) }
        translatable.save
      end

      def translate_field(translatable, field, to: I18n.locale)
        translatable.translations.build(
          field: field,
          language: to,
          translation: @translator.translate(translatable.send(field), from: translatable.language_field, to: to)
        ) if @translator.can_translate?(translatable, field, to)
      end

    end

    class InvalidTranslatorError < StandardError
      def to_s
        "Unable to instantiate translator: Please ensure that the appropriate ENV variables are set"
      end
    end
  end
end
