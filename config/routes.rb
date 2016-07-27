Rails.application.routes.draw do

  root "activities#index"
  resources :activities, only: [:index,:show] do
    resources :papers
    resources :categories
    get '/reviews' => 'reviews#index', as: 'reviews'
    get '/reviews/:id' => 'reviews#review', as: 'review'
    get '/reviews/:id/reviewed' => 'reviews#reviewed', as: 'reviewed'
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  as :user do
    get 'my_proposals' => "users/index#show"
    get 'users/edit' => 'users/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'users/registrations#update', :as => 'user_registration'
  end

  namespace :admin do
    resources :activities do
      resources :reviewers, only: [:index,:new,:create,:destroy]
    end
    get '/users' => "users#index"
    get '/users/:id/designate' => "users#designate", as: 'user_designate'
    get '/users/:id/undesignate' => "users#undesignate", as: 'user_undesignate'
  end

end
