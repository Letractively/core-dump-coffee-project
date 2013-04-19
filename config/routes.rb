Venshop::Application.routes.draw do
  root to: 'home#home'

  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete

  match '/post',  to: 'products#new'
  match '/posted',  to: 'products#posted'
  match '/addcart',  to: 'cart#addcart'
  match '/unsetcart',  to: 'cart#unsetcart'
  match '/deletecart',  to: 'cart#deletecart'
  match '/checkout',  to: 'order#new'

  resources :users
  resources :sessions,      only: [:new, :create, :destroy]
  resources :getdata
  resources :categories,	only: [:index, :show]
  resources :products
  resources :search,		only: [:index]
  resources :cart
  resources :order
end
