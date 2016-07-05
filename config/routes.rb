Rails.application.routes.draw do
	
  devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', 
  	                             password: 'secret', confirmation: 'verification', 
  	                             unlock: 'unblock', registration: 'register', 
  	                             sign_up: 'cmon_let_me_in' }
  root 'question#index'
  resources :question, only: [:index, :new, :show, :create] do
    resources :answer
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
