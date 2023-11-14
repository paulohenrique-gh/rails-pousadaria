class RoomsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  before_action only: [:show, :edit, :update] do
    set_room(params[:id])
  end

  before_action only: [:new, :create] do
    set_guesthouse_and_check_user(params[:guesthouse_id])
  end

  before_action only: [:show, :edit, :update] do
    set_guesthouse_and_check_user(@room.guesthouse_id)
  end

  before_action :redirect_new_host_to_guesthouse_creation

  def show
    @active_seasonal_rates = @room.seasonal_rates.active
  end

  def new
    @room = Room.new(guesthouse: @guesthouse)
  end

  def create
    @room = Room.new(room_params)
    @room.guesthouse = @guesthouse
    if @room.save
      redirect_to @guesthouse, notice: 'Quarto cadastrado com sucesso'
    else
      flash.now[:alert] = 'Não foi possível adicionar quarto'
      render 'new', status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @room.update(room_params)
      redirect_to @room, notice: 'Quarto atualizado com sucesso'
    else
      flash.now[:alert] = 'Não foi possível atualizar quarto'
      render 'new', status: :unprocessable_entity
    end
  end

  private

  def room_params
    params.require(:room).permit(:name, :description, :dimension,
                                 :max_people, :daily_rate,
                                 :private_bathroom, :balcony,
                                 :air_conditioning, :tv, :closet,
                                 :safe, :accessibility, :available)
  end
end
