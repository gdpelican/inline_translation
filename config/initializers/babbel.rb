ActiveSupport.on_load(:active_record) { include InlineTranslation::Concerns::ActsAsTranslatable }
ActiveSupport.on_load(:action_view)   { include InlineTranslation::Helpers::TranslationsHelper }
