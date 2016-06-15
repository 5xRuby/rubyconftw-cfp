Rails.application.routes.draw do

  root "activities#index"
  resources :activities do
    resources :papers
    resources :categories
  end
  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  as :user do
    get 'users' => "users/index#show"
    get 'users/edit' => 'users/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'users/registrations#update', :as => 'user_registration'
  end
  
  get '/reviews' => 'reviews#index', as: 'reviews' 
  get '/reviews/:id' => 'reviews#review', as: 'review'
  get '/reviews/:id/reviewed' => 'reviews#reviewed', as: 'reviewed'
    
end
