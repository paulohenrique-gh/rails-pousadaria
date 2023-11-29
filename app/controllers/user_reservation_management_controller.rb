class UserReservationManagementController < ApplicationController
  before_action :authenticate_user!, only: [:index, :active_reservations_index,
                                            :manage, :confirm_checkin, :cancel,
                                            :go_to_checkout, :confirm_checkout]
  before_action :set_reservation, only: [:manage, :confirm_checkin, :cancel,
                                         :go_to_checkout, :confirm_checkout]
  before_action :check_user, only: [:manage, :confirm_checkin, :cancel,
                                    :go_to_checkout, :confirm_checkout]

  def index
    @reservations = current_user.guesthouse.reservations.order(:checkin)
  end

  def active_reservations_index
    @reservations = current_user.guesthouse
                                .reservations
                                .guests_checked_in
                                .order(:checkin)
  end

  def manage
    @checkin_elligible = @reservation.elligible_for_checkin?
    @cancellation_elligible = @reservation.elligible_for_cancellation_by_user?
    @checkout_elligible = @reservation.guests_checked_in?
  end

  def cancel
    @reservation.user_cancel
    if @reservation.cancelled?
      return redirect_to(user_reservations_path,
                         notice: 'Reserva cancelada com sucesso')
    else
      redirect_to(user_reservations_path,
                  alert: 'Não foi possível cancelar reserva')
    end
  end

  def confirm_checkin
    guest_params.each do |guest_data|
      @guest_checkin = GuestCheckin.new(guest_data)
      @guest_checkin.reservation = @reservation

      unless @guest_checkin.save
        flash.now[:alert] = 'Não foi possível confirmar o check-in'
        return render :manage, status: :unprocessable_entity
      end
    end

    @reservation.guests_checked_in!
    if @reservation.guests_checked_in?
      return redirect_to(user_manage_reservation_path(@reservation.id),
                         notice: 'Check-in confirmado com sucesso')
    else
      redirect_to(user_manage_reservation_path(@reservation.id),
                  alert: 'Não foi possível confirmar o check-in')
    end
  end

  def go_to_checkout
    begin
      @reprocessed_total = @reservation.reprocess_stay_total
      session[:reprocessed_total] = @reprocessed_total
    rescue => e
      redirect_to manage_reservation_path(@reservation.id), alert: e.message
    end

    @payment_methods = @reservation.guesthouse
                                   .attributes
                                   .slice("payment_method_one",
                                          "payment_method_two",
                                          "payment_method_three")
                                   .values
                                   .compact
    @purchase_total = @reservation.purchases
                        .pluck(:price, :quantity)
                        .reduce(0) { |sum, (price, quantity)| sum + (price * quantity) }
    session[:purchase_total] = @purchase_total
  end

  def confirm_checkout
    @reservation.stay_total = session[:reprocessed_total] + session[:purchase_total]
    if reservation_params[:payment_method].nil?
      return redirect_to(go_to_checkout_reservation_path(@reservation.id),
                         alert: 'Forma de pagamento não pode ficar vazia')
    end

    @reservation.payment_method = reservation_params[:payment_method]

    @reservation.guests_checked_out!
    session.delete(:reprocessed_total)
    session.delete(:purchase_total)
    redirect_to(user_reservations_path,
                notice: 'Estadia finalizada com sucesso')
  end

  private

  def reservation_params
    params.require(:reservation)
          .permit(:checkin, :checkout, :guest_count,
                  :stay_total, :room_id, :payment_method)
  end

  def guest_params
    guest_data_collection = []
    @reservation.guest_count.times do |index|
      guest_data_collection << params[:guest].require(index.to_s)
                                             .permit(:guest_name, :document)
    end

    guest_data_collection
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def check_user
    if set_reservation.guesthouse.user != current_user
      redirect_to root_path
    end
  end
end
