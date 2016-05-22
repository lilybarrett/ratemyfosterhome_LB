Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]

  namespace :admin do
     resources :users, only: [:index, :update, :destroy]
  end

  resources :foster_kids

  resources :foster_homes do
    resources :foster_kid_reviews, only: [:new, :create]
    resources :foster_parent_reviews, only: [:new, :create]
    resources :social_worker_reviews, only: [:new, :create]
  end

  resources :foster_parents

  get "home", to: "home#show"

  root 'home#show'

  get 'foster_homes/:id/unassign' => 'foster_homes#unassign',
    as: :foster_homes_unassign

  get "foster_homes/:id/thank_you", to: "foster_homes#thank_you",
    as: :foster_homes_thank_you
end
