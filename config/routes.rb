Rails.application.routes.draw do
  mount API => '/'
  
  devise_for :photographers , controllers: {registrations: 'registrations'}
  root to: "photographers#sign_in"
      resources :photographers do
      member do
        get 'profile'
        post 'update_password'
      end
      get 'eventsinfo'
        resources :clients do
        get 'show1'       
        resources :events do 
          member do
            get 'upload_images'
            post 'upload_images'
            get  'all_images'
            get "image", as: :event_image
          end
        end
      end
    end
    resources :clients do
      resources :events do
        get 'all_images'
        get 'image/:id' => 'events#image'
        get 'image/:id/like' => 'events#like'
      end
    end
end