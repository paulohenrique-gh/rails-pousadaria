Rails.application.routes.draw do
  devise_for :users, :guests
  root to: 'home#index'

  get 'my-guesthouse', to: 'guesthouses#user_guesthouse'
  get 'guesthouses-by-city/:city', to: 'guesthouses#by_city', as: :guesthouses_by_city
  get 'quick-search', to: 'guesthouse_search#quick_search'
  get 'advanced-search', to: 'guesthouse_search#advanced_search'
  get 'search-results', to: 'guesthouse_search#search_results'
  get 'my-reservations', to: 'reservations#guest_index'
  get 'my-guesthouse-reservations', to: 'reservations#user_index'
  get 'my-active-reservations', to: 'reservations#user_active_reservations'
  post 'abandon-reservation', to: 'reservations#abandon'

  resources :guesthouses, only: [:new, :create, :edit, :update, :show], shallow: true do
    resources :rooms, only: [:new, :create, :edit, :update, :show] do
      get 'confirm', to: 'reservations#confirm'
      resources :reservations, only: [:new, :create] do
        patch :cancellation_by_guest, on: :member
        patch :cancellation_by_user, on: :member
        get :manage, on: :member
        patch :confirm_checkin, on: :member
        get :go_to_checkout, on: :member
        patch :confirm_checkout, on: :member
      end
      resources :seasonal_rates, only: [:new, :create, :show] do
        patch :inactivate, on: :member
      end
    end

    patch :inactivate, on: :member
    patch :reactivate, on: :member
  end
end
