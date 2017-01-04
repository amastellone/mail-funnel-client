Rails.application.routes.draw do

  # Main
  root :to => 'main_interface#index'
  get '/campaign/:campaign_id', to: 'main_interface#campaign'

  # Funnel-Builder
  get '/funnel/:campaign_id', to: 'funnel_builder#index'

  # Funnel-Builder JSON API
  post '/fbapi_index' => 'funnel_builder#api_index'
  post '/fbapi_update' => 'funnel_builder#api_update'
  post '/fbapi_read' => 'funnel_builder#api_read'
  post '/fbapi_create' => 'funnel_builder#api_create'
  post '/fbapi_delete' => 'funnel_builder#api_delete'

  get '/campaignjobs/:id', to: 'campaigns#viewcampaignjobs'

  # Email Controller
  get '/lists', to: 'email#lists'
  get '/emails/:list_id', to: 'email#emails'
  get '/new_list', to: 'email#new_list'
  match '/create_list' => 'email#create_list', via: [:post]

  # Scaffolds
  # resources :mail_funnel_configs
  # resources :email_lists

  # Shopify Routes
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

  mount ShopifyApp::Engine, at: '/'

  # namespace :app_proxy do
  #   root action: 'index'
    # simple routes without a specified controller will go to AppProxyController

    # resources :hooks_constants
    # resources :users
      # resources :campaigns

    # more complex routes will go to controllers in the AppProxy namespace
    # 	resources :reviews
    # GET /app_proxy/reviews will now be routed to
    # AppProxy::ReviewsController#index, for example
  # end
end
