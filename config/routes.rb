Rails.application.routes.draw do
  root :to =>"homes#top"
  devise_for :users
  get "home/about"=>"homes#about"

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorites, only: %w[create destroy]
    resources :book_comments, only: %w[create destroy]
  end

  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: %w[create destroy]
    resources :follow_relationships, only: :index
    resources :follower_relationships, only: :index
  end

  get 'searches/search', as: 'searches'
end

