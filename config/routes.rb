Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'registrations'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'dashboards#index'

  resources :users do
    resources :exercises
  end

  namespace :dashboards do
    post :search
  end

  resources :friendships, only: %i[show create destroy]
end
