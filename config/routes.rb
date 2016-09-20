Rails.application.routes.draw do
  devise_for :users
 resources :entries  do
 	resources :comments
 end
 resource :user, only: [:edit, :update]
 get 'welcome/index'
 root 'welcome#index'

   resources :users do
    member do
      get :following, :followers
    end
  end

end
