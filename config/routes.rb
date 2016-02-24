Rails.application.routes.draw do

#  devise_for :photographers 
  

devise_for :photographers , controllers: {registrations: 'api/v1/registrations'}


  root to: "api/v1/photographers#sign_in"
  get "api/v1/login" => "api/v1/pages#login"  
  namespace :api  do
    namespace :v1 do
     #  resources :pages do
     #    collection do
     #     get 'login'
     #   end
     # end
     resources :photographers do
      member do
        get 'profile'
        #get 'update_password'
        post 'update_password'
      end
      get 'eventsinfo'
      resources :clients do
        get 'show1'       
        resources :events do 
          member do
            #get 'showevents'
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
end
  #get "/photographers/:photographer_id/clients/:client_id/events/:event_id/show_images/:id" => 'events#show_images', as: :event_image


  #get "/photographers/:photographer_id/clients/:client_id/events/:event_id/all_images/:id" => 'events#all_images', as: :all_images
end
