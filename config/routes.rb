Ens::Application.routes.draw do
  resources :notifications
  resources :e911s

  devise_for :users
  root to: "home#index"
end
