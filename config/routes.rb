Rails.application.routes.draw do
  root :to => 'home#index'
  resource :book, only: [:index]
  devise_for :users
  resources :users, only: [:show, :edit, :update, :index]
  resources :books
  resources :home, only: [:index]
  get 'home/about' => 'home#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
