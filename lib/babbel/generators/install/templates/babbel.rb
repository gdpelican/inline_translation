ActiveSupport.on_load(:active_record) do
  include Babbel::IsTranslatable
end