require 'action_view/helpers'

module InlineTranslation
  module Helpers
    module TranslationsHelper
      include ActionView::Helpers

      def translate_link_for(translatable, to: I18n.locale, text: "Translate")
        link_to text, path_for(translatable, to), method: :post, remote: true if translatable.language != to
      end

      def translated_element_for(translatable, field, element: :span, to: I18n.locale)
        content_tag element, '', class: "#{field}-translated to-#{to} inline-translation-translated"
      end

      private

      def path_for(translatable, to)
        translations_path translatable_id: translatable.id,
                          translatable_type: translatable.class.to_s,
                          to: to,
                          action: :create
        end
    end
  end
end
