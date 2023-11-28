class PurchasesController < ApplicationController
  def new
    @reservation = Reservation.find(params[:reservation_id])
    @purchase = Purchase.new
    session[:reservation_id] = @reservation.id
  end

  def create
    if session[:reservation_id].nil?
      return redirect_to active_reservations_path
    end

    @reservation = Reservation.find(session[:reservation_id])
    @purchase = Purchase.new(purchase_params)
    @purchase.reservation = @reservation
    if @purchase.save
      redirect_to(user_manage_reservation_path(@reservation.id),
                  notice: 'Consumo registrado com sucesso')
      session.delete(:reservation_id)
    else
      flash.now[:alert] = 'Não foi possível registrar consumo'
      render :new, status: :unprocessable_entity
      session.delete(:reservation_id)
    end
  end

  private

  def purchase_params
    params.require(:purchase).permit(:product_name, :price, :quantity)
  end

end
