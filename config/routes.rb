Rails.application.routes.draw do
  get 'cart_items/index'
  get 'items/index'
  get 'items/show'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
