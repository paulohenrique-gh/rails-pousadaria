class HomeController < ApplicationController
  def index
    if current_user && current_user.host?
      return @guesthouse = current_user.guesthouse
    end

    @guesthouses = Guesthouse.active
  end
end
