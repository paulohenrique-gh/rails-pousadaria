class GuesthousesController < ApplicationController
  def new
    @guesthouse = Guesthouse.new
    @guesthouse.build_address
  end

  def create
    @guesthouse = Guesthouse.new(guesthouse_params)
    @guesthouse.user = current_user

    if @guesthouse.save
      redirect_to root_path, notice: 'Pousada cadastrada com sucesso'
    else

    end
  end

  private

  def guesthouse_params
    params.require(:guesthouse).permit(
      :brand_name, :corporate_name, :registration_number,
      :phone_number, :email, :description, :address_id,
      :payment_method_one, :payment_method_two, :payment_method_three,
      :pet_policy, :guesthouse_policy, :checkin_time, :checkout_time,
      address_attributes: [
        :street_name, :number, :complement, :neighbourhood,
        :postal_code, :city, :state
      ]
    )
  end
end
