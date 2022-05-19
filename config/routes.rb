Rails.application.routes.draw do
  
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  

  resources :stories

  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
 end

   
  # Defines the root path route ("/")
   root "pages#index"
end
