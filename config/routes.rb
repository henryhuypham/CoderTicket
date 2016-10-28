Rails.application.routes.draw do
  root 'events#index'

  resources :events do
    post :order, on: :collection

    resources :tickets
  end
end
