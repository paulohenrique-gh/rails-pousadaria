Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :guesthouses, only: [:new, :create, :edit, :update]
end
