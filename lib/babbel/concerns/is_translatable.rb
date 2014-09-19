module Babbel
  module IsTranslatable
    extend ActiveSupport::Concern
    
    module ClassMethods
      def is_translatable(on: [], load_via: :find, id_field: :id, language_field: :language)
        include Translatable
        define_singleton_method :translatable_fields, -> { Array on }
        define_singleton_method :get_instance,        ->(id) { send load_via, id }
        define_method :id_field,                      -> { send id_field }
        define_method :language_field,                -> { send language_field }
      end
    end
  end
end