Rails.application.routes.draw do
  resources :produtos
  #get 'home/index'
  get 'auth/sign_in'
  post 'sign_in', to: 'auth#sign_in'
  delete 'sign_out', to: 'auth#sign_out'

  get 'home/about'
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
