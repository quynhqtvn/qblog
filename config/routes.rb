Rails.application.routes.draw do
  devise_for :users
 resources :entries  do
 	resources :comments
 end
 resources :user, only: [:edit, :update]
 get 'welcome/index'
 root 'welcome#index'
end
