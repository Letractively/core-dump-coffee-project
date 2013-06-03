Venshop::Application.routes.draw do
  root to: 'home#home'
  
  match '/switch_locale', to: 'application#switch_locale'
  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete
  match '/email_request', to: 'sessions#email_request'
  match '/sessions/send_token', to: 'sessions#send_token'
  match '/reminder/update' , to: 'sessions#update_pass'

  match '/post',  to: 'products#new'
  match '/posted',  to: 'products#posted'
  match '/addcart',  to: 'cart#addcart'
  match '/unsetcart',  to: 'cart#unsetcart'
  match '/deletecart',  to: 'cart#deletecart'
  match '/checkout',  to: 'order#new'

  match '/products/leave_comment', to: 'products#leave_comment'
  match '/product/new', to: 'admin#product_new'
  match '/category/new', to: 'admin#category_new'
  match '/category/create', to: 'admin#category_create'
  match '/product/create', to: 'admin#product_create'
  match '/product/edit/:id', to: 'admin#product_edit'
  match '/admin/product_save', to: 'admin#product_save'
  match '/admin/destroy_product/:id', to: 'admin#product_destroy'
  match '/admin/product_manager', to: 'admin#product_manager'

  match '/admin/categories', to: 'admin#categories'
  match '/admin/category_edit/:id', to: 'admin#category_edit'
  match '/admin/category_save', to: 'admin#category_save'
  match '/admin/category_destroy/:id', to: 'admin#category_destroy'

  match '/admin/index', to: 'admin#index'
  match '/admin/users', to: 'admin#users'
  match '/admin/user_info/:id', to: 'admin#user_info'
  match '/admin/user_edit/:id', to: 'admin#user_edit'
  match '/admin/user_save' , to: 'admin#user_save'
  match '/admin/user_destroy', to: 'admin#user_destroy'
  match '/admin/user_order/:id', to: 'admin#user_order'

  match '/admin/report', to: 'admin#report'
  match '/admin/report_month', to: 'admin#report_month'
  match '/admin/report_day', to: 'admin#report_day'


  resources :users
  resources :sessions,   only: [:new, :create, :destroy]
  resources :getdata
  resources :categories,	only: [:index, :show]
  resources :products
  resources :search,	only: [:index]
  resources :cart
  resources :order
end

