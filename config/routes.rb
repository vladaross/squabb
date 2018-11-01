# frozen_string_literal: true

Rails.application.routes.draw do
  get 'profile/show'
  resources :replies
  resources :categories
  resources :votes do
    member do
      get :like, to: 'votes#like', as: :like
      get :dislike, to: 'votes#dislike', as: :dislike
    end
  end
  resources :discussions do
    collection do
      get :search, to: 'discussions#search', as: :search
      get :popular, to: 'discussions#popular', as: :popular
      get :most_upvoted, to: 'discussions#most_upvoted', as: :most_upvoted
    end
    member do
      post :vote, to: 'discussions#vote'
      resources :arguments
    end
  end

  root 'discussions#index'
  devise_for :users
  resources :users
  get :user, to: 'users#profile', as: :profile
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
