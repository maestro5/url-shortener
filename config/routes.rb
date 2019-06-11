Rails.application.routes.draw do
  root 'links#index'

  resources :links, only: :create

  get '*internal_link', to: 'links#show'
end
