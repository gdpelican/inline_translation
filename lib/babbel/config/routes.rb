Rails.application.routes.draw do
  resources :translations, only: :create
end