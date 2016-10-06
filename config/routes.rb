Rails.application.routes.draw do
  root "activities#index"

  resource :contributors, only: [:show]
  resources :activities, only: [:index,:show] do
    resources :papers
    resources :categories, only: [:index, :show]
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
      resources :papers, only: [:index, :show, :update] do
        resources :comments, only: [:create, :destroy]
      end
      resources :mails, only: [:create]
      resources :speakers, only: [:index]
    end
    resources :papers, only: [] do
      resources :reviews, only: [:create]
      post 'accept' => "reviews#accept"
      post 'reject' => "reviews#reject"
    end

    resources :users, only: [:index] do
      resource :contributor, only: [:create, :destroy]

      get '/designate' => "users#designate"
      get '/undesignate' => "users#undesignate"
    end
  end
end
