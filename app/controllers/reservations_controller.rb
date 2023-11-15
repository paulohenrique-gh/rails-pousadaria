class ReservationsController < ApplicationController
  before_action :authenticate_guest!, only: [:create, :guest_index]

  def new
    @room = Room.find(params[:room_id])
    @reservation = Reservation.new
  end

  def confirm
    @room = Room.find(params[:room_id])

    checkin = params[:reservation][:checkin].to_date
    checkout = params[:reservation][:checkout].to_date
    guest_count = params[:reservation][:guest_count].to_i
    days_count = (checkout - checkin).to_i + 1

    stay_total = @room.current_daily_rate * days_count

    @reservation = Reservation.new(checkin: checkin, checkout: checkout,
                                   guest_count: guest_count,
                                   stay_total: stay_total, room: @room)

    if guest_count > @room.max_people
      flash[:alert] = 'Quantidade de hóspedes excede capacidade do quarto'
      return render :new
    end

    unless @room.available_for_reservation?(checkin, checkout)
      flash.now[:alert] = 'Quarto não disponível no período informado'
      render :new
    end
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.guest = current_guest

    if @reservation.save
      redirect_to my_reservations_path, notice: 'Reserva registrada com sucesso'
    end
  end

  def guest_index
    @reservations = Reservation.where(guest: current_guest)
    render 'index'
  end

  def inactivate

  end

  private

  def reservation_params
    params.permit(:checkin, :checkout, :guest_count, :stay_total, :room_id)
  end
end
