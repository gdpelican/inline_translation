ActiveSupport.on_load(:active_record) { include Babbel::Concerns::ActsAsTranslatable }
ActiveSupport.on_load(:action_view)   { include Babbel::Helpers::TranslationsHelper }
