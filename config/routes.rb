Rails.application.routes.draw do
<<<<<<< HEAD
  root  'public/homes#top'
=======

root "public/homes#top"
get "/home/about" => "public/homes#about", as: "about"

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



>>>>>>> origin/develop
end
