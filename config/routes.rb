Rails.application.routes.draw do
  resources :mail_funnel_configs
  mount ShopifyApp::Engine, at: '/'

  root :to => 'home#index'

  get '/funnel', to: 'funnel_builder#index'
  get '/campaignjobs/:id', to: 'campaigns#viewcampaignjobs'
  get '/lists', to: 'emails#lists'
  get '/emails/:id', to: 'emails#emails'


  get 'modal' => "home#modal", :as => :modal
  get 'modal_buttons' => "home#modal_buttons", :as => :modal_buttons
  get 'regular_app_page' => "home#regular_app_page"
  get 'help' => "home#help"
  get 'pagination' => "home#pagination"
  get 'breadcrumbs' => "home#breadcrumbs"
  get 'buttons' => "home#buttons"
  get 'form_page' => "home#form_page"
  post 'form_page' => "home#form_page"
  get 'error' => 'home#error'

  resources :campaigns

  namespace :app_proxy do
    root action: 'index'
    # simple routes without a specified controller will go to AppProxyController

    # resources :hooks_constants
    # resources :users
    resources :campaign_jobs
    # resources :campaigns

    # more complex routes will go to controllers in the AppProxy namespace
    # 	resources :reviews
    # GET /app_proxy/reviews will now be routed to
    # AppProxy::ReviewsController#index, for example
  end
end
