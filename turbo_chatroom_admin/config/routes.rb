Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "messages#index"
  resources :test

  resources :messages, only: [:index] do
    member do
      get :hide
    end
  end
end
