Rails.application.routes.draw do
  devise_for :users, :guests
  root to: 'home#index'

  get 'guesthouses-by-city/:city', to: 'guesthouses#by_city', as: :guesthouses_by_city

  resources :guesthouses, only: [:new, :create, :edit, :update, :show], shallow: true do
    get 'quick-search', to: 'guesthouse_search#quick_search', on: :collection
    get 'advanced-search', to: 'guesthouse_search#advanced_search', on: :collection
    get 'search-results', to: 'guesthouse_search#search_results', on: :collection
    get 'reviews', to: 'guesthouses#reviews', on: :member
    delete 'delete-picture', to: 'guesthouses#delete_picture', on: :member

    resources :rooms, only: [:new, :create, :edit, :update, :show] do
      get 'confirm', to: 'reservations#confirm'
      delete 'delete-picture', to: 'rooms#delete_picture', on: :member

      resources :reservations, only: [:new, :create] do
        get :user_manage, to: 'user_reservation_management#manage', on: :member
        patch :user_cancel, to: 'user_reservation_management#cancel', on: :member
        patch :confirm_checkin, to: 'user_reservation_management#confirm_checkin', on: :member
        get :go_to_checkout, to: 'user_reservation_management#go_to_checkout', on: :member
        patch :confirm_checkout, to: 'user_reservation_management#confirm_checkout', on: :member

        get :guest_manage, to: 'guest_reservation_management#manage', on: :member
        patch :guest_cancel, to: 'guest_reservation_management#cancel', on: :member

        resources :reviews, only: [:new, :create] do
          get :respond, to: 'reviews#respond', on: :member
          post :save_response, to: 'reviews#save_response', on: :member
        end
      end

      resources :seasonal_rates, only: [:new, :create, :show] do
        patch :inactivate, on: :member
      end
    end

    patch :inactivate, on: :member
    patch :reactivate, on: :member
  end

  scope :user do
    get :guesthouse, to: 'guesthouses#user_guesthouse', as: :user_guesthouse
    get :reservations, to: 'user_reservation_management#index', as: :user_reservations
    get :active_reservations, to: 'user_reservation_management#active_reservations_index'
    get :reviews, to: 'reviews#user_reviews', as: :user_reviews
  end

  scope :guest do
    get :reservations, to: 'guest_reservation_management#index', as: :guest_reservations
  end

  namespace :api do
    namespace :v1 do
      resources :guesthouses, only: [:index, :show] do
        resources :rooms, only: [:index]
      end

      resources :rooms, only: [:check_availability] do
        get :check_availability
      end
    end
  end
end
