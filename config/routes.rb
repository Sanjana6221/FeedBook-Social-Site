Rails.application.routes.draw do
	root to: "posts#index"
  devise_for :users 
  resources :posts
  resources :profile, only: [:show, :edit, :update]
end


