require 'sidekiq/web'
Rails.application.routes.draw do
  authenticate :user, -> (user) { user.admin? } do
    # No route 'GET /sidekiq'
    # TODO root_path unless user.admin?
    mount Sidekiq::Web => '/sidekiq'
  end
  use_doorkeeper
  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout', 
  	                             password: 'secret', confirmation: 'verification', 
  	                             unlock: 'unblock', registration: 'register', 
  	                             sign_up: 'cmon_let_me_in' },
                                 controllers: { omniauth_callbacks: 'omniauth_callbacks/omniauth_callbacks'}
  root 'questions#index'

  resources :authorizations, only: [:show]
  resources :users, only:[:update, :show]
  # resources :subscribtions, only: [:create]

  concern :subscribtable do
    resources :subscribtions, defaults: { format: 'json' }, only: [:create, :show, :destroy]
  end

  concern :votable do
    resources :votes, defaults: { format: 'json' }, only: [:create, :destroy]
  end

  concern :commentable do
    resources :comments, only: [:create, :destroy]
  end

  resources :questions, concerns: [:votable, :commentable, :subscribtable], except: [:edit], shallow: true do
    resources :answers, concerns: [:votable, :commentable], only: [:create, :update, :destroy]
  end

  namespace :api do
    namespace :v1 do
      resource :profiles do
        get :me, on: :collection
        get :index, on: :collection 
      end
      resources :questions, only: [:index, :show, :new, :create], shallow: true do
        resources :answers, only: [:index, :show, :new, :create]
      end
    end
  end
  mount ActionCable.server => '/cable'
end