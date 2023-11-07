class HomeController < ApplicationController
  before_action :redirect_new_host_to_guesthouse_creation, only: [:index]

  def index
    @recent_guesthouses = Guesthouse.active.order(created_at: :desc).first(3)
    @other_guesthouses = Guesthouse.active.order(created_at: :desc)[3..] || []
  end
end
