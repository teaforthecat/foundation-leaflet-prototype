Ens::Application.routes.draw do

  resources :geos

  #allow post and put methods
  post 'geos/:id' => 'geos#update'

  resources :notifications

  resources :e911s


  devise_for :users
  root to: "home#index"
end
