Rails.application.routes.draw do
  devise_for :users
  resources :orders
  resources :members
  resources :users
  resources :items do
    collection do
      post :available_quantity
    end
  end
  resources :carts

  root 'orders#index'
  get 'renew/:id' => 'orders#renew'
  get 'return/:id' => 'orders#disable'
  get 'past_orders' => 'orders#old'
  post '/add_to_cart/' => 'carts#add_to_cart', :as => 'add_to_cart'
  delete 'destroy_member' => 'members#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
