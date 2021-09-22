Rails.application.routes.draw do
  devise_for :users
  root to: "shops#index"

  resources :points, only: [:new, :create] do
    collection do
      get 'search'
    end
  end

  resources :shops, only: [:new, :create, :show, :edit, :update, :destroy] do
    resources :comments, only: :create
    collection do
      get 'search'
      get 'shop_search'
    end
  end

  resources :users, only: :show
end
