Ens::Application.routes.draw do

  resources :notifications

  resources :geo

  resources :e911s


  devise_for :users
  root to: "home#index"
end
