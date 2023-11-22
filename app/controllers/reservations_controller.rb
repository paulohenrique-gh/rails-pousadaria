class ReservationsController < ApplicationController
  before_action only: [:create] do
    sign_out(current_user) if current_user.present?
  end

  before_action :authenticate_guest!, only: [:create]

  def new
    @room = Room.find(params[:room_id])
    @reservation = Reservation.new
  end

  def confirm
    @room = Room.find(params[:room_id])
    session[:reservation] = params[:reservation]

    if session[:reservation].nil?
      return redirect_to new_room_reservation_path(@room.id)
    end

    checkin = session[:reservation][:checkin].to_date
    checkout = session[:reservation][:checkout].to_date
    guest_count = session[:reservation][:guest_count].to_i

    @reservation = Reservation.new(checkin: checkin, checkout: checkout,
                                   guest_count: guest_count, room: @room)

    stay_total = @reservation.calculate_stay_total(checkin, checkout)
    @reservation.stay_total = stay_total

    unless @reservation.valid?
      return render :new
    end

    if @room.booked?(checkin, checkout)
      flash.now[:alert] = 'Quarto não disponível no período informado'
      render :new
    end

    session[:reservation] = @reservation
  end

  def create
    if session[:reservation].nil?
      return redirect_to new_room_reservation_path(params[:room_id])
    end

    @reservation = Reservation.new(session[:reservation])
    if @reservation.room.booked?(@reservation.checkin, @reservation.checkout)
      session.delete(:reservation)
      return redirect_to(
        new_room_reservation_path(@reservation.room_id),
        alert: 'Quarto não está mais disponível. Selecione outra data.'
      )
    end

    @reservation.guest = current_guest
    session.delete(:reservation)

    if @reservation.save
      return (redirect_to my_reservations_path,
              notice: 'Reserva registrada com sucesso')
    else
      flash.now[:alert] = 'Não foi possível concluir a reserva'
      redirect_to new_room_reservation_path(params[:room_id])
    end
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def check_user
    if set_reservation.guesthouse.user != current_user
      redirect_to root_path
    end
  end
end
