Rails.application.routes.draw do
 	devise_for :users
 	resources :entries  do
 		resources :comments
 	end

 	resources :users, only: [:edit, :update ]
 	get 'welcome/index'
 	root 'welcome#index'

	resources :users, :path => "users" do
	member do
	  get :following, :followers
	end
	end

  	resources :relationships, only: [:create, :destroy]

end
