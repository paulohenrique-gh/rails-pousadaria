Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :guesthouses, only: [:new, :create, :edit, :update, :show] do
    resources :rooms, only: [:new, :create, :show]
    patch :inactivate, on: :member
    get 'search', on: :collection
  end
end
