Rails.application.routes.draw do
  get 'orders/new'
  get 'orders/log'
  get 'orders/finish'
  get 'orders/index'
  get 'orders/show'
  get 'homes/top'
  get 'homes/about'
  devise_for :admins
  devise_for :customers
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
