Rails.application.routes.draw do
  resources :translations, only: :create, module: 'babbel/controllers', as: :translations
end