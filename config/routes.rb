Ens::Application.routes.draw do

  resources :notifications

  get 'map_editor', to: "notifications#map_editor"

  resources :e911s


  devise_for :users
  root to: "home#index"
end
