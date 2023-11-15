class SeasonalRatesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :show, :inactivate]
  before_action :set_seasonal_rate, only: [:show, :inactivate]
  before_action only: [:show] do
    set_room(@seasonal_rate.room_id)
  end

  before_action only: [:new, :create] do
    set_room(params[:room_id])
  end

  before_action only: [:new, :create] do
    set_guesthouse_and_check_user(@room.guesthouse_id)
  end

  before_action only: [:show, :inactivate] do
    set_guesthouse_and_check_user(@seasonal_rate.room.guesthouse_id)
  end

  def show
    if @seasonal_rate.inactive?
      redirect_to root_path, alert: 'Preço por período já inativo'
    end
  end

  def new
    @seasonal_rate = SeasonalRate.new(room: @room)
  end

  def create
    @seasonal_rate = SeasonalRate.new(seasonal_rate_params)
    @seasonal_rate.room = @room

    if @seasonal_rate.save
      redirect_to @room, notice: 'Preço por período cadastrado com sucesso'
    else
      flash.now[:alert] = 'Não foi possível cadastrar preço por período'
      render 'new', status: :unprocessable_entity
    end
  end

  def inactivate
    @seasonal_rate.inactive!
    redirect_to(
      @seasonal_rate.room,
      notice: 'Preço por período excluído com sucesso'
    )
  end

  private

  def seasonal_rate_params
    params.require(:seasonal_rate).permit(:start_date, :finish_date, :rate)
  end

  def set_seasonal_rate
    @seasonal_rate = SeasonalRate.find(params[:id])
  end
end
