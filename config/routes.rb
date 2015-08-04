Rails.application.routes.draw do
  resources :translations, only: :create, module: 'inline_translation/controllers', as: :translations
end