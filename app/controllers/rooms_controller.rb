class RoomsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @guesthouse = Guesthouse.find(params[:guesthouse_id])
    @room = Room.new(guesthouse: @guesthouse)
  end

  def create
    @guesthouse = Guesthouse.find(params[:guesthouse_id])

    @room = Room.new(room_params)
    @room.guesthouse = @guesthouse
    if @room.save
      redirect_to @guesthouse, notice: 'Quarto cadastrado com sucesso'
    else
      flash.now[:alert] = 'Não foi possível adicionar quarto'
      render 'new', status: :unprocessable_entity
    end
  end

  private

  def room_params
    params.require(:room).permit(:name, :description, :dimension,
                                 :max_people, :daily_rate,
                                 :private_bathroom, :balcony,
                                 :air_conditioning, :tv, :closet,
                                 :safe, :accessibility)
  end
end
