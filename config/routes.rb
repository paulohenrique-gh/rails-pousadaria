Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  root to: 'home#index'

  get 'my_guesthouse', to: 'guesthouses#user_guesthouse'
  get 'by_city/:city', to: 'guesthouses#by_city', as: :guesthouses_by_city

  resources :guesthouses, only: [:new, :create, :edit, :update, :show] do
    resources :rooms, only: [:new, :create, :edit, :update, :show] do
      resources :seasonal_rates, only: [:new, :create, :edit, :update] do
        patch :inactivate, on: :member
      end
    end

    patch :inactivate, on: :member
    get 'search', on: :collection
  end
end
