class GuesthousesController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  # before_action :set_guesthouse, only: [:edit, :update]

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
      flash.now[:alert] = 'Não foi possível cadastrar pousada'
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
    @guesthouse = Guesthouse.find(params[:id])
    if @guesthouse.user != current_user
      redirect_to root_path, notice: 'Você não tem autorização para alterar esta pousada'
    end
  end

  def update
    @guesthouse = Guesthouse.find(params[:id])
    @guesthouse.update(guesthouse_params)
    redirect_to root_path, notice: 'Pousada atualizada com sucesso'
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

  # def set_guesthouse
  #   @guesthouse = Guesthouse.find(params[:id])
  #   if @guesthouse.user != current_user
  #     redirect_to root_path, notice: 'Você não tem autorização para alterar esta pousada'
  #   end
  # end
end
