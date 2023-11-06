class SeasonalRatesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create,
                                            :edit, :update, :inactivate]

  before_action only: [:new, :create, :edit, :update, :inactivate] do
    set_guesthouse_and_check_user(params[:guesthouse_id])
  end

  before_action only: [:new, :create, :edit, :update, :inactivate] do
    set_room(params[:room_id])
  end
  before_action :set_seasonal_rate, only: [:edit, :update, :inactivate]

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

  def edit; end

  def update
    if @seasonal_rate.update(seasonal_rate_params)
      redirect_to([@seasonal_rate.room.guesthouse,@seasonal_rate.room],
                  notice: 'Preço por período atualizado com sucesso')
    else
      flash.now[:alert] = 'Não foi possível atualizar preço por período'
      render 'edit', status: :unprocessable_entity
    end
  end

  def inactivate
    @seasonal_rate.inactive!
    redirect_to(
      [@guesthouse, @room],
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
