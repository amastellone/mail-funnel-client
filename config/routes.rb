Rails.application.routes.draw do
  root :to => 'home#index'
  resources :hooks_constants
  resources :users
  resources :campaign_jobs
  resources :campaigns
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
