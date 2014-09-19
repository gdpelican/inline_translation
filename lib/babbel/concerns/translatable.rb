module Babbel
  module Translatable
    extend ActiveSupport::Concern

    included do
      has_many :translations, as: :translatable
      before_update :destroy_modified_translations

      private

      def destroy_modified_translations
        translations.each { |t| t.destroy if changed.include? t.field }
      end
    end
  end
end