Rails.application.routes.draw do
  mount API => '/'
  root to: "photographers#sign_in"
  devise_for :photographers , controllers: {registrations: 'registrations', omniauth_callbacks: "photographers/omniauth_callbacks"}
  
  resources :photographers do
    member do
      post 'update_password'
      get 'new_achievement', as: :new_achievement
      post 'add_achievements', as: :add_achievements
    end
    get 'events_info'
    resources :clients do
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