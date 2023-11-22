class GuestReservationManagementController < ApplicationController
  before_action :authenticate_guest!, only: [:index, :manage, :cancel]
  before_action :set_reservation, only: [:manage, :cancel]
  before_action :check_guest, only: [:cancel]

  def index
    @reservations = current_guest.reservations.reverse
  end

  def manage
    @cancellation_elligible = @reservation.elligible_for_cancellation_by_guest?
  end

  def cancel
    @reservation.guest_cancel
    if @reservation.cancelled?
      return redirect_to(reservations_guest_path,
                         notice: 'Reserva cancelada com sucesso')
    else
      redirect_to(reservations_guest_path,
                  alert: 'Não foi possível cancelar reserva')
    end
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def check_guest
    if set_reservation.guest != current_guest
      redirect_to root_path
    end
  end
end
