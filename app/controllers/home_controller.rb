class HomeController < ApplicationController
  before_action :redirect_new_host_to_guesthouse_creation, only: [:index]

  def index
    @guesthouses = Guesthouse.active
  end
end
