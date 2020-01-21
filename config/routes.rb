Rails.application.routes.draw do
  root 'transactions#index'

  resources :transactions, only: :create
end
