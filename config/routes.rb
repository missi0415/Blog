Rails.application.routes.draw do

  # プロフィール編集をパスワード無しにする
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  root "homes#top"

  resources :users, only: [:index, :show, :create] do
    resource :relationships, only: [:create, :destroy]
    get :following, :followers
  end

  resources :books do
    resources :comments, only: [:create, :destroy, :update]
    resource :likes, only: [:create, :destroy]
  end

  get "/search", to: "books#search"

  resources :categories, only: [:index, :create, :show]

  resources :chats, only: [:create]
  get "chat/:id" => "chats#show", as: "chat"
end
