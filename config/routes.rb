Rails.application.routes.draw do

  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout', 
  	                             password: 'secret', confirmation: 'verification', 
  	                             unlock: 'unblock', registration: 'register', 
  	                             sign_up: 'cmon_let_me_in' },
                                 controllers: { omniauth_callbacks: 'omniauth_callbacks/omniauth_callbacks' }
  root 'questions#index'

  resources :authorizations, only: [:show]
  resources :user, only:[:update]

  concern :votable do
    resources :votes, defaults: { format: 'json' }, only: [:create, :destroy]
  end

  concern :commentable do
    resources :comments, only: [:create, :destroy]
  end

  resources :questions, concerns: [:votable, :commentable], shallow: true do
    resources :answers, concerns: [:votable, :commentable]
  end
end
