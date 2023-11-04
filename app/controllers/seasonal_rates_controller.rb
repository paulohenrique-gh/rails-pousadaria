class SeasonalRatesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  before_action only: [:new, :create] do
    set_guesthouse_and_check_user(params[:guesthouse_id])
  end

  before_action :set_room, only: [:new, :create]

  def new
    @seasonal_rate = SeasonalRate.new(room: @room)
  end

  def create
    @seasonal_rate = SeasonalRate.new(seasonal_rate_params)
    @seasonal_rate.room = @room

    if @seasonal_rate.save
      redirect_to([@room.guesthouse, @room],
                  notice: 'Preço por período cadastrado com sucesso')
    else
      flash.now[:alert] = 'Não foi possível cadastrar preço por período'
      render 'new', status: :unprocessable_entity
    end
  end

  private

  def seasonal_rate_params
    params.require(:seasonal_rate).permit(:start_date, :finish_date, :rate)
  end

  def set_room
    @room = Room.find(params[:room_id])
  end
end
