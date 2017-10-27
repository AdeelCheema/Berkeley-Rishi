Rails.application.routes.draw do
  get 'about', to: 'home#about'
  get 'signin', to: 'home#authen'
  get 'home/back'
  get 'home/index'
  root 'home#index'
  resources 'members'
  
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  delete 'signout', to: 'sessions#destroy', as: 'signout'

  resources :sessions, only: [:create, :destroy]

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
end
