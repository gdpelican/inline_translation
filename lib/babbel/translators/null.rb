module Babbel
  module Translators
    class Null < Base
      
      def ready?
        true
      end

      def translate(text, from: nil, to: I18n.locale)
        nil
      end

    end
  end
end