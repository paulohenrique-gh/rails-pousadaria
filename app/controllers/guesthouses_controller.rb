class GuesthousesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit,
                                            :update, :inactivate]

  before_action  only: [:edit, :update,:inactivate] do
    set_guesthouse_and_check_user(params[:id])
  end

  before_action :check_guesthouse_presence, only: [:new, :create]

  before_action :redirect_host_to_guesthouse_creation, except: [:new, :create]

  def show
    @guesthouse = Guesthouse.find(params[:id])
    @user = current_user
    @available_rooms = @guesthouse.rooms.where(available: true)
    @all_rooms = @guesthouse.rooms
  end

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

  def edit; end

  def update
    if @guesthouse.update(guesthouse_params)
      redirect_to root_path, notice: 'Pousada atualizada com sucesso'
    else
      flash.now[:alert] = 'Não foi possível atualizar a pousada'
      render 'edit', status: :unprocessable_entity
    end
  end

  def inactivate
    @guesthouse.inactive!
    redirect_to root_path, notice: 'Pousada inativada com sucesso'
  end

  def search
    @query = params[:query]
    @guesthouses = Guesthouse.active.where("brand_name LIKE ?", "%#{@query}%")
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

  def check_guesthouse_presence
    if current_user.guesthouse
      redirect_to root_path, alert: 'Você já possui uma pousada cadastrada'
    end
  end
end
