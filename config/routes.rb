Rails.application.routes.draw do
 resources :entries
 get 'welcome/index'
 root 'welcome#index'
end
