Rails.application.routes.draw do
  devise_for :clients
  mount API => '/'
    devise_for :photographers , controllers: {registrations: 'registrations', omniauth_callbacks: "photographers/omniauth_callbacks"}
  devise_scope :photographer do
    authenticated :photographer do
      root :to => 'photographers#show'
    end
    unauthenticated :photographer do
      root :to => 'devise/sessions#new', as: :unauthenticated_root
    end
  end 

  get '/get_forms', to: "clients#get_forms"
  get '/setting_partial', to: "photographers#setting_partial"
  get 'download_app', to: "clients#download_app"
  post 'photographers/connect_client', to: "photographers#connect_client"
  get "scheduled_events/:date", to: "events#scheduled_events"
  get 'expiries', to: "home#expires", as: :expires
  get 'update_paln', to: "home#plan_update", as: :plan_update
  get 'search_clients', to: "clients#search_clients", as: :search_clients
  post 'clients/event', to: "events#create_calender_event", as: :create_calender_event
  resources :photographers do
    resources :albums do
      get 'public_image'
      post 'public_image'
    end
    member do
      patch 'update_password'
      get "settings"
      get "profile"
      get 'new_achievement', as: :new_achievement
      post 'add_achievements', as: :add_achievements
    end
    get 'events_info'
    resources :clients do
      get 'selected_images', to: "clients#selected_images", as: :selected_images
      resources :events do 
        member do
          get 'upload_images'
          get 'upload_image'
          post 'upload_images'
          get  'all_images'
          get "image", as: :event_image
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
      get 'image/:id' => 'events#image'
      get 'image/:id/like' => 'events#like'
    end
  end
end