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
    get "top" => "homes#top"

    resources :customers,only: [:index, :show, :edit, :update] do
    end

    resources :items,only: [:new, :index, :show, :edit, :create, :update ] do
    end

    resources :genres,only: [:index, :edit, :create, :update ] do
    end

    resources :making_status,only: [:update] do
    end

    resources :orders,only: [:show, :update ] do
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
    get 'customers/unsubscribe' => 'customers#unsubscribe'
    resources :customers,only: [:show, :edit, :update ] do
    end

    resources :items,only: [:index, :show ] do
    end

    get 'orders/finish' => 'orders#finish'
    get 'orders/comfirm' => 'orders#comfirm'
    resources :orders,only: [:new, :create, :index, :show ] do
    end
  end

end
