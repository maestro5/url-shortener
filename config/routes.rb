Rails.application.routes.draw do
  root 'transactions#index'

  resources :sales, only: :index, module: 'analytics'

  resources :transactions, only: :create
end
