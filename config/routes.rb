Rails.application.routes.draw do

  get 'customers/index'
  get 'customers/show'
  get 'customers/edit'
  get 'addresses/index'
  get 'addresses/edit'
  get 'customers/show'
  get 'customers/edit'
  get 'customers/exit'
  get 'customers/withdraw'

  get 'cart_items/index'
  get 'items/index'
  get 'items/show'

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
