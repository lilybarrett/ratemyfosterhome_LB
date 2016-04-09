Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]

  namespace :admin do
     resources :users, only: [:index, :update, :destroy]
  end

  resources :foster_kids

  resources :foster_homes do
    resources :reviews, only: [:new, :create]
  end

  resources :foster_parents

  get "home", to: "home#show"

  root 'home#show'

end
