Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "restaurants#index"
  resources :restaurants, only: [:index, :show] do
    resources :comments, only: [:create, :destroy]

    #瀏覽所有餐廳的最新動態
    collection do 
      get :feeds
      get :ranking
    end


    member do 
      #瀏覽個別餐廳的Dashboard
      get :dashboard
      post :favorite
      post :unfavorite
      post :like
      post :unlike
    end

  end

  resources :users, only: [:index,:show,:edit,:update] do
    member do
      get :friend_list  #好友清單
    end    
  end

  resources :followships, only: [:create,:destroy]

  resources :friendships, only: [:create,:destroy]

  resources :categories, only: [:show]

  namespace :admin do 
    resources :categories
    resources :restaurants
    root "restaurants#index"

  end
end
