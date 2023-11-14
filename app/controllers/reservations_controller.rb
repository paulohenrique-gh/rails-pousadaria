class ReservationsController < ApplicationController
  def new
    @room = Room.find(params[:room_id])
    @reservation = Reservation.new
  end
end
