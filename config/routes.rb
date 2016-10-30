Rails.application.routes.draw do
  get   'venues/index'
  post  'venues/new'

  get   'login', to: 'sessions#login'
  post  'login', to: 'sessions#login'
  get   'sign_up', to: 'sessions#sign_up'
  post  'sign_up', to: 'sessions#sign_up'
  get   'sign_out', to: 'sessions#sign_out'

  resources :events do
    post  :order, on: :collection
    get   :created_by_me, on: :collection
    post  :create_event, on: :collection
    post  :publish_event, on: :collection
    resources :tickets do
      get   :create_type, on: :collection
      post  :create_type, on: :collection
    end
  end

  root  'events#index'
end
