Rails.application.routes.draw do
  root "pages#home"
  devise_for :users

  resources :users, only: [:show]

  resources :users, only: [] do 
    resources :contacts, only: [:index, :create, :destroy]
  end
  
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
