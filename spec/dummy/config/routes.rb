Rails.application.routes.draw do
  root 'home#index'
  resource :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:show, :create], param: :username

  mount ProveKeybase::Engine => "/prove_keybase"
end
