class ReservationsController < ApplicationController
  before_action :authenticate_guest!, only: [:create]

  def new
    @room = Room.find(params[:room_id])
    @reservation = Reservation.new
  end

  def confirm
    @room = Room.find(params[:room_id])

    checkin = params[:reservation][:checkin].to_date
    checkout = params[:reservation][:checkout].to_date
    guest_count = params[:reservation][:guest_count]
    days_count = (checkout - checkin).to_i + 1

    stay_total = @room.current_daily_rate * days_count
    @reservation = Reservation.new(checkin: checkin, checkout: checkout,
                                   guest_count: guest_count,
                                   stay_total: stay_total, room: @room)

    unless @reservation.valid?
      return render :new
    end

    unless @room.available_for_reservation?(checkin, checkout)
      flash.now[:alert] = 'Quarto não disponível no período informado'
      render :new
    end
  end

  def create

  end
end
