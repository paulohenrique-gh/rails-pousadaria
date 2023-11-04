class SeasonalRatesController < ApplicationController
  before_action :set_room, only: [:new]

  def new
    @seasonal_rate = SeasonalRate.new(room: @room)
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end
end
