Personal::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  resource :sessions, :only => [:create]
  get 'sign_in' => 'sessions#new'
  get 'sign_out' => 'sessions#destroy'
  resources :password_recoveries, :only => [:new, :create, :edit, :update]
  root "home#index"

  resources :keychains

end
