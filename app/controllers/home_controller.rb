class HomeController < ApplicationController
  def index
    if current_user.host?
      @guesthouse = current_user.guesthouse
    end
  end
end
