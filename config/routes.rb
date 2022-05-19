Rails.application.routes.draw do
  
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  

  resources :stories

  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
 end

 # /@tinayu/title-123
 get '@:username/:story_id', to: 'pages#show', as: 'story_page'

 # /@tinayu/
 get '@:username', to: 'pages#user', as: 'user_page'

   
  # Defines the root path route ("/")
   root "pages#index"
end
