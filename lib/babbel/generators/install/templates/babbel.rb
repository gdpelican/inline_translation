ActiveSupport.on_load(:active_record) do
  include Babbel::IsTranslatable
end

ActionView::Base.on_load do
  include, Babbel::Helpers::TranslationsHelper
end

Babbel.translator = Babbel::Translators::Bing