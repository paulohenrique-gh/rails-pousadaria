class GuesthousesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update,
                                            :inactivate, :reactivate, :user_guesthouse]

  before_action  only: [:edit, :update, :inactivate] do
    set_guesthouse_and_check_user(params[:id])
  end

  before_action :set_guesthouse, only: [:show, :reactivate, :reviews]
  before_action :check_guesthouse_presence, only: [:new, :create]
  before_action :redirect_new_host_to_guesthouse_creation, only: [:show]

  def show
    @user = current_user
    redirect_to root_path if @user.nil? && @guesthouse.inactive?
    set_guesthouse_info(@guesthouse)
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
    @guesthouse.assign_attributes(guesthouse_params)

    if params[:guesthouse][:pictures].present?
      @guesthouse.pictures.attach(params[:guesthouse][:pictures])
    end

    if @guesthouse.save
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

  def reactivate
    if current_user && @guesthouse.user == current_user
      @guesthouse.active!
      return redirect_to @guesthouse, notice: 'Pousada reativada com sucesso'
    else
      redirect_to root_path
    end
  end

  def user_guesthouse
    @user = current_user
    @guesthouse = @user.guesthouse
    set_guesthouse_info(@guesthouse)

    render 'show', status: :ok
  end

  def by_city
    @city = params[:city]
    addresses_by_city = Address.where(city: @city)
    @available_guesthouses = Guesthouse.active
                                       .where(address: addresses_by_city)
                                       .order(:brand_name)
    redirect_to root_path if @available_guesthouses.empty?
  end

  def reviews
    @reviews = @guesthouse.reviews.order(:created_at).reverse
    @average_rating = @guesthouse.reviews.average(:rating).to_f
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

  def set_guesthouse
    @guesthouse = Guesthouse.find(params[:id])
  end

  def set_guesthouse_info(guesthouse)
    @available_rooms = @guesthouse.rooms.where(available: true)
    @all_rooms = @guesthouse.rooms
    @recent_reviews = @guesthouse.reviews.order(:created_at).reverse.first(3)
    @average_rating = @guesthouse.reviews.average(:rating).to_f
  end

  def check_guesthouse_presence
    if current_user && current_user.guesthouse
      redirect_to root_path, alert: 'Você já possui uma pousada cadastrada'
    end
  end
end
