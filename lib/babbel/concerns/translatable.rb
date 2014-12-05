module Babbel
  module Concerns
    module Translatable
      extend ActiveSupport::Concern
      included do
        has_many :translations, as: :translatable, class_name: 'Babbel::Models::Translation'
        before_update :destroy_modified_translations

        private

        def destroy_modified_translations
          translations.each { |t| t.destroy if changed.include? t.field }
        end
      end
    end
  end
end