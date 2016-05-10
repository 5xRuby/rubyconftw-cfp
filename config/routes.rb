Rails.application.routes.draw do

  resources :activities do
    resources :papers
  end
  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  as :user do
    get 'users/edit' => 'users/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'users/registrations#update', :as => 'user_registration'
  end
end
