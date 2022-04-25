Rails.application.routes.draw do
  #顧客側のTOPページとaboutページのルーティング
  root "public/homes#top"
  get "about" => "public/homes#about"

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

#管理者側のルーティング
  namespace :admin do
    root "homes#top"

    resources :customers,only: [:index, :show, :edit, :update] do
    end

    resources :items,only: [:new, :index, :show, :edit, :create, :update ] do
    end

    resources :genres,only: [:index, :edit, :create, :update ] do
    end

    resources :making_status,only: [:update] do
    end

    resources :orders,only: [:index, :show ] do
      patch '/orders/:id/order_status' => 'orders#order_status_update', as: "order_status" # 注文ステータスupdate
      patch '/orders/:id/item_status' => 'orders#item_status_update', as: "item_status" # 製作ステータスupdate
    end
  end

#顧客側のルーティング
  scope module: :public do
    resources :addresses,only: [:index, :edit, :create, :update, :destroy ] do
    end

    resources :cart_items,only: [:index, :create, :update, :destroy ] do
      collection do
        delete 'all_destroy'
      end
    end

    patch '/customers/withdraw' => 'customers#withdraw', as: 'withdraw'
    get 'customers/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
    resources :customers,only: [:show, :edit, :update ] do
    end

    resources :items,only: [:index, :show ] do
    end

    post 'orders/finish' => 'orders#finish'
    post 'orders/comfirm' => 'orders#comfirm'
    resources :orders,only: [:new, :create, :index, :show ] do
    end
  end

end
