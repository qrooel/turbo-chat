Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  # Defines the root path route ("/")
  root "messages#index"
  resources :test

  resources :messages, only: [:index] do
    member do
      get :hide
    end
  end
end
