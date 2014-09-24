module Babbel
  module Translators
  	class Bing < Base
      attr_reader :translator

      def initialize
        @translator = BingTranslator.new ENV['BING_TRANSLATOR_APP_ID'], ENV['BING_TRANSLATOR_SECRET']
      end

      def ready?
        ENV['BING_TRANSLATOR_APP_ID'] && ENV['BING_TRANSLATOR_SECRET'] && true
      end

      def translate(text, from: nil, to: I18n.locale)
        @translator.translate text, from: from, to: to
      end

  	end
  end
end