Rails.application.routes.draw do
	root to: "feeds#index"
  devise_for :users
  resources :feeds
end


