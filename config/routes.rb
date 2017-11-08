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
      member do
        put :dup
      end
      resources :reviewers, only: [:index,:new,:create,:destroy]
      resources :papers, only: [:index, :show, :update] do
        resources :comments, only: [:create, :destroy]
      end
      resources :mails, only: [:create]
      resources :speakers, only: [:index]
      resource :stats, only: [:show]
    end
    resources :papers, only: [] do
      resources :reviews, only: [:create]
      post 'approve' => "reviews#approve"
      post 'disapprove' => "reviews#disapprove"
      post 'accept' => "reviews#accept"
      post 'reject' => "reviews#reject"
    end

    resources :tags, only: [:index]

    resources :users, only: [:index, :edit, :update] do
      resource :contributor, only: [:create, :destroy]

      get '/designate' => "users#designate"
      get '/undesignate' => "users#undesignate"
    end
  end
end
