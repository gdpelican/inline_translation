require 'bing_translator'

module InlineTranslation
  module Translators
    class Bing < Base

      def self.ready?
        ENV['BING_TRANSLATOR_APP_ID'] && ENV['BING_TRANSLATOR_SECRET'] && true
      end

      def initialize
        @translator = ::BingTranslator.new ENV['BING_TRANSLATOR_APP_ID'], ENV['BING_TRANSLATOR_SECRET']
      end

      def translate(text, from: nil, to: I18n.locale)
        @translator.translate text, from: from, to: to
      end

    end
  end
end