class ReservationsController < ApplicationController
  before_action only: [:create] do
    sign_out(current_user) if current_user.present?
  end


  before_action :authenticate_guest!, only: [:create, :guest_index, :cancellation_by_guest]
  before_action :authenticate_user!, only: [:confirm_checkin, :user_index,
                                            :user_active_reservations, :manage]
  before_action :set_reservation, only: [:manage, :confirm_checkin, :cancellation_by_guest,
                                         :cancellation_by_user]
  before_action :check_guest, only: [:cancellation_by_guest]
  before_action :check_user, only: [:confirm_checkin, :manage]

  def new
    @room = Room.find(params[:room_id])
    @reservation = Reservation.new
  end

  def confirm
    @room = Room.find(params[:room_id])
    if params[:reservation].nil?
      return redirect_to new_room_reservation_path(@room.id)
    end

    checkin = params[:reservation][:checkin].to_date
    checkout = params[:reservation][:checkout].to_date
    guest_count = params[:reservation][:guest_count].to_i
    days_count = (checkout - checkin).to_i + 1

    stay_total = @room.calculate_stay_total(checkin, checkout)

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
    @reservation = Reservation.new(reservation_params)
    @reservation.guest = current_guest

    if @reservation.save
      redirect_to my_reservations_path, notice: 'Reserva registrada com sucesso'
    else
      flash.now[:alert] = 'Não foi possível concluir a reserva'
      render 'new', status: :unprocessable_entity
    end
  end

  def guest_index
    @reservations = current_guest.reservations.reverse
    render 'index'
  end

  def user_index
    @reservations = current_user.guesthouse.reservations.order(:checkin)
    render 'index'
  end

  def user_active_reservations
    @reservations = current_user.guesthouse.reservations.guests_checked_in
  end

  def manage
    @checkin_elligible = @reservation.elligible_for_checkin?
    @cancellation_elligible = @reservation.elligible_for_cancellation_by_user?
  end

  def confirm_checkin
    @checkin_elligible = @reservation.elligible_for_checkin?
    if @checkin_elligible
      @reservation.guests_checked_in!
      return redirect_to(manage_reservation_path(@reservation.id),
                         notice: 'Check-in confirmado com sucesso')
    else
      redirect_to(manage_reservation_path(@reservation.id),
                  alert: 'Não foi possível confirmar o check-in')
    end
  end

  def cancellation_by_guest
    @reservation.guest_cancel
    if @reservation.cancelled?
      return redirect_to(my_reservations_path,
                         notice: 'Reserva cancelada com sucesso')
    else
      redirect_to(my_reservations_path,
                  alert: 'Não foi possível cancelar reserva')
    end
  end

  def cancellation_by_user
    @reservation.user_cancel
    if @reservation.cancelled?
      return redirect_to(my_guesthouse_reservations_path,
      notice: 'Reserva cancelada com sucesso')
    else
      redirect_to(my_guesthouse_reservations_path,
                  alert: 'Não foi possível cancelar reserva')
    end
  end

  private

  def reservation_params
    params.permit(:checkin, :checkout, :guest_count, :stay_total, :room_id)
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def check_guest
    if set_reservation.guest != current_guest
      redirect_to root_path
    end
  end

  def check_user
    if set_reservation.guesthouse.user != current_user
      redirect_to root_path
    end
  end
end
