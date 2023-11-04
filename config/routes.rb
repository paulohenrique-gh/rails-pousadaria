Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :guesthouses, only: [:new, :create, :edit, :update, :show] do
    resources :rooms, only: [:new, :create, :edit, :update, :show] do
      resources :seasonal_rates, only: [:new, :create]
    end
    patch :inactivate, on: :member
    get 'search', on: :collection
  end
end
