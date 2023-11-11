Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  root to: 'home#index'

  get 'my-guesthouse', to: 'guesthouses#user_guesthouse'
  get 'guesthouses-by-city/:city', to: 'guesthouses#by_city',
                                   as: :guesthouses_by_city
  # get 'advanced-search', to: 'guesthouses#advanced_search', as: :advanced_search
  # get 'advanced-search-results', to: 'guesthouses#advanced_search_results',
  #                                as: :advanced_search_results

  get 'quick-search', to: 'guesthouse_search#quick_search'
  get 'advanced-search', to: 'guesthouse_search#advanced_search'
  get 'search-results', to: 'guesthouse_search#search_results'

  resources :guesthouses, only: [:new, :create, :edit, :update, :show] do
    resources :rooms, only: [:new, :create, :edit, :update, :show] do
      resources :seasonal_rates, only: [:new, :create, :show] do
        patch :inactivate, on: :member
      end
    end

    patch :inactivate, on: :member
    patch :reactivate, on: :member
  end
end
