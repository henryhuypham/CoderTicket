Rails.application.routes.draw do
  get   'venues/index'
  post  'venues/new'

  get   'login', to: 'sessions#login'
  post  'login', to: 'sessions#login'
  get   'sign_up', to: 'sessions#sign_up'
  post  'sign_up', to: 'sessions#sign_up'
  get   'sign_out', to: 'sessions#sign_out'

  root  'events#index'

  resources :events do
    post  :order, on: :collection
    get   :created_by_me, on: :collection
    resources :tickets
  end
end
