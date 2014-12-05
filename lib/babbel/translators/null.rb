module Babbel
  module Translators
    class Null < Base

      def self.ready?
        true
      end

      def initialize
      end

      def translate(text, from: nil, to: I18n.locale)
        nil
      end

    end
  end
end