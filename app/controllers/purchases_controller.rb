class PurchasesController < ApplicationController
  def new
    @reservation = Reservation.find(params[:reservation_id])
    @purchase = Purchase.new
  end
end
