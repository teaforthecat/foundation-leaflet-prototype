Ens::Application.routes.draw do

  resources :geos do
    member do
      post :pub
      get :sub
    end
  end

  resources :notifications

  resources :e911s


  devise_for :users
  root to: "home#index"
end
