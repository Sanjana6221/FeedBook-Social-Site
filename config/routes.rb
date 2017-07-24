Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    authenticated :user do
      root 'posts#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :posts
  resources :profile, only: [:show] 
  resources :friendships
  resources :users do
    get 'search', on: :collection
  end
end

