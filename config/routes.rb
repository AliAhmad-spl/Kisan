Rails.application.routes.draw do
  resources :payments
  resources :accounts
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :charges
  
  resources :companies
  devise_for :users,  controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
      }
  resources :orders
  resources :members
  resources :users
  resources :items do
    collection do
      post :available_quantity
    end
  end
  resources :carts do
    member do
      get :remove
      get :clear 
    end
  end

  root 'orders#index'
  get 'renew/:id' => 'orders#renew'
  get 'return/:id' => 'orders#disable'
  get 'past_orders' => 'orders#old'
  post '/add_to_cart/' => 'carts#add_to_cart', :as => 'add_to_cart'
  delete 'destroy_member' => 'members#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
