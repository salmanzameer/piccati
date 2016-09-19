Rails.application.routes.draw do

  get  'admins/new'
  get  'admins/dashboard'
  get  'admins/albums', as: :admin_albums
  get  'admins/album_images'
  post  'admins/update_all_images'
  get  'admins/plans', as: :admin_plans
  get  'admins/photographer_plans', as: :photographer_plans
  post 'admins/edit_plan'
  post 'admins/update_plan'
  get  'admins/change_status'
  get  'admins/new_plan'
  post 'admins/create_plan'
  get  'admins/destroy_plan'
  get  'admins/clients', as: :admin_client
  get  'admins/photographers', as: :admin_photographer

  devise_for :clients, controllers: { invitations: 'invitations', sessions: 'sessions', registrations: 'registrations' }

  devise_for :admins
  
  mount API => '/'
  
  devise_for :photographers , controllers: { invitations: 'invitations', sessions: 'sessions', registrations: 'registrations', omniauth_callbacks: "photographers/omniauth_callbacks" }
  
  devise_scope :photographer do
    authenticated :photographer do
      root :to => 'photographers#show'
    end

    unauthenticated :photographer do
      root :to => 'devise/sessions#new', as: :unauthenticated_root
    end
  end 

  post '/invite_client',   to: "clients#invite_client"
  get  '/get_forms',       to: "clients#get_forms"
  get  '/setting_partial', to: "photographers#setting_partial"
  get  '/download_app',    to: "clients#download_app"

  post 'photographers/connect_client', to: "photographers#connect_client"
  get  "scheduled_events/:date",       to: "events#scheduled_events"
  get  'expiries',                     to: "home#expires",                   as: :expires
  get  'download/:token',              to: "home#download",                  as: :download
  get  'update_plan',                  to: "photographers#plan_update",      as: :plan_update
  get  'search_clients',               to: "clients#search_clients",         as: :search_clients
  post 'clients/event',                to: "events#create_calender_event",   as: :create_calender_event
  post 'share_image_url/:client_id',   to: "clients#share_image_url",        as: :share_image_url
  
  resources :packages
  get  '/client_package_update/:package_id', to: "packages#client_package_update"

  resources :photographers do
    get  'export_clients', to: "clients#export_clients_csv", as: :export_clients_csv
    post 'import_clients', to: "clients#import_clients_csv", as: :import_clients_csv
    
    resources :albums do
      get 'public_image'
      post 'public_image'
      delete 'image_destroy/:id', to: "albums#image_destroy", as: :image_destroy
    end
    
    member do
      patch 'update_password'
      get   "settings"
      get   "profile"
      get   'new_achievement',  as: :new_achievement
      post  'add_achievements', as: :add_achievements
    end
    
    get 'events_info'
    resources :clients do
      get 'selected_images', to: "clients#selected_images", as: :selected_images
      resources :events do 
        member do
          get  'selected_images'
          get  'upload_images'
          get  'upload_image'
          post 'upload_images'
          get  'all_images'
          get  "image", as: :event_image
        end
      end
    end
  end

  resources :clients do
    member do 
      get "edit_package"
      put "update_package"
      get "client_events"
      get "event"
    end

    collection do
      post "connect_client"
      get  "search_client_fields"
    end

    resources :events do
      get 'all_images'
      get 'image/:id'      => 'events#image'
      get 'image/:id/like' => 'events#like'
    end
  end
end