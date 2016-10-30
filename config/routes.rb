Rails.application.routes.draw do
  get   'login', to: 'sessions#login'
  get   'sign_up', to: 'sessions#sign_up'

  root  'events#index'

  resources :events do
    post :order, on: :collection
    resources :tickets
  end
end
