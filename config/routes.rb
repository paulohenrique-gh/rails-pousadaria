Rails.application.routes.draw do
  devise_for :users, :guests
  root to: 'home#index'

  get 'my-guesthouse', to: 'guesthouses#user_guesthouse'
  get 'guesthouses-by-city/:city', to: 'guesthouses#by_city', as: :guesthouses_by_city

  resources :guesthouses, only: [:new, :create, :edit, :update, :show], shallow: true do
    get 'quick-search', to: 'guesthouse_search#quick_search', on: :collection
    get 'advanced-search', to: 'guesthouse_search#advanced_search', on: :collection
    get 'search-results', to: 'guesthouse_search#search_results', on: :collection

    resources :rooms, only: [:new, :create, :edit, :update, :show] do
      get 'confirm', to: 'reservations#confirm'
      resources :reservations, only: [:new, :create] do
        get :user_manage, to: 'user_reservation_management#manage', on: :member
        patch :user_cancel, to: 'user_reservation_management#cancel', on: :member
        patch :confirm_checkin, to: 'user_reservation_management#confirm_checkin', on: :member
        get :go_to_checkout, to: 'user_reservation_management#go_to_checkout', on: :member
        patch :confirm_checkout, to: 'user_reservation_management#confirm_checkout', on: :member

        get :guest_manage, to: 'guest_reservation_management#manage', on: :member
        patch :guest_cancel, to: 'guest_reservation_management#cancel', on: :member

        resources :reviews, only: [:new, :create]
      end

      resources :seasonal_rates, only: [:new, :create, :show] do
        patch :inactivate, on: :member
      end
    end

    patch :inactivate, on: :member
    patch :reactivate, on: :member
  end

  resource :reservations, only: [:index] do
    get :guest, to: 'guest_reservation_management#index'
    get :host, to: 'user_reservation_management#index'
    get :active, to: 'user_reservation_management#active_reservations_index'
  end
end
