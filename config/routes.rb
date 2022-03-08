Rails.application.routes.draw do
  get 'signup/create'
  root to: 'index#index'
  resources :playlists
  resources :videos

  post "refresh", controller: :refresh, action: :create
  post "signup", controller: :signup, action: :create
  post "signin", controller: :signin, action: :create
  delete "signin", controller: :signin, action: :destroy
  
end