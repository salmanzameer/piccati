Rails.application.routes.draw do
  devise_for :clients
  mount API => '/'
  root to: "photographers#sign_in"
  devise_for :photographers , controllers: {registrations: 'registrations', omniauth_callbacks: "photographers/omniauth_callbacks"}
  
  get "scheduled_events/:date", to: "events#scheduled_events"
  get 'expiries', to: "home#expires", as: :expires
  get 'update_paln', to: "home#plan_update", as: :plan_update
  get 'search_clients', to: "clients#search_clients", as: :search_clients
  resources :photographers do
    resources :albums do
      get 'public_image'
      post 'public_image'
    end
    member do
      post 'update_password'
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
      get "client_events"
      get "event"
    end
    collection do
      post "connect_client"
    end
    resources :events do
      get 'all_images'
      get 'image/:id' => 'events#image'
      get 'image/:id/like' => 'events#like'
    end
  end
end