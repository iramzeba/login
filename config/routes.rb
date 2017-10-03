Rails.application.routes.draw do
 
  #devise_for :users
   get 'auth/:provider/callback', to: 'sessions#create'
    get 'auth/failure', to: redirect('/')
    get 'signout', to: 'sessions#destroy', as: 'signout'

  get 'sessions/create'

  get 'sessions/destroy'

	
 get 'auth/:provider/callback', to: 'users#facebook'
	resources :users do
		collection do

  get 'sign_in'
  post 'signup'
  delete 'logout'
  get 'forget_password'
  post 'recover_password'

  end
end
 resources :sessions, only: [:create, :destroy]
  
root 'users#sign_in'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
