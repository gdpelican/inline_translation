ActiveSupport.on_load(:active_record) do
  include Babbel::IsTranslatable
end

Babbel.translator = Babbel::Translators::Bing