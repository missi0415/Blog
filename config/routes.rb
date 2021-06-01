Rails.application.routes.draw do

  # プロフィール編集をパスワード無しにする
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  root "homes#top"
end
