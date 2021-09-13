Rails.application.routes.draw do
  devise_for :users
  root to: "shops#index"
  resources :points, only: [:new, :create] do
    collection do
      get 'search'
    end
  end
  resources :shops, only: [:new, :create, :show] do
    collection do
      get 'search'
    end
  end
end
