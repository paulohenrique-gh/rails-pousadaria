class HomeController < ApplicationController
  before_action :redirect_host_to_guesthouse_creation, only: [:index]

  def index
    # debugger
    @guesthouses = Guesthouse.active
  end
end
