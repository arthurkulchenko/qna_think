Rails.application.routes.draw do
	
  devise_for :users
  root 'question#index'
  resources :question, only: [:index, :new, :show, :create] do
    resources :answer
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
