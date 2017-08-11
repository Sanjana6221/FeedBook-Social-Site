Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  devise_scope :user do
    authenticated :user do
      root 'posts#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
  
  resources :posts 
  resources :bookmark,only: [:index,:create,:destroy]
  resources :profile, only: [:show] 
  resources :friendships  do
    post 'fb_friends', :on => :collection
  end
  resources :users do
    get 'search', on: :collection
  end
 
end

