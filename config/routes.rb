Rails.application.routes.draw do
  devise_for :users
 resources :entries
 get 'welcome/index'
 root 'welcome#index'
end
