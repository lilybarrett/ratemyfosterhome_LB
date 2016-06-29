Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show, :destroy]

  namespace :admin do
    resources :users, only: [:index, :show, :destroy]
  end

  get "users/:id/update_status", to: "users#update_status",
    as: :update_status

  resources :foster_kids, except: [:new]

  resources :foster_parents, except: [:new]

  resources :foster_homes do
    resources :foster_kid_reviews, only: [:new, :create]
    resources :foster_parent_reviews, only: [:new, :create]
    resources :social_worker_reviews, only: [:new, :create]
    resources :social_worker_case_comments, only: [:new, :create]
  end

  resources :foster_homes do
    resources :foster_kids, only: [:edit, :update]
    resources :foster_parents, only: [:edit, :update]
  end

  get "foster_homes/:id/unassign", to: 'foster_homes#unassign',
    as: :foster_homes_unassign

  get "foster_homes/:id/thank_you", to: "foster_homes#thank_you",
    as: :foster_homes_thank_you

  get "home", to: "home#show"

  devise_scope :user do
    authenticated :user do
      root 'home#show', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

end
