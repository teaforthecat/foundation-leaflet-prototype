Ens::Application.routes.draw do
  resources :notifications

  devise_for :users
  root to: "home#index"
end
