Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  root to: 'home#index'

  get 'my-guesthouse', to: 'guesthouses#user_guesthouse'
  get 'guesthouses-by-city/:city', to: 'guesthouses#by_city',
                                   as: :guesthouses_by_city

  resources :guesthouses, only: [:new, :create, :edit, :update, :show] do
    resources :rooms, only: [:new, :create, :edit, :update, :show] do
      resources :seasonal_rates, only: [:new, :create, :show] do
        patch :inactivate, on: :member
      end
    end

    patch :inactivate, on: :member
    patch :reactivate, on: :member
    get 'search', on: :collection
  end
end
