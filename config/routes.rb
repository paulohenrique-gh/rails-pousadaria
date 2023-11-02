Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :guesthouses, only: [:new, :create, :edit, :update] do
    patch :inactivate, on: :member
  end
end
