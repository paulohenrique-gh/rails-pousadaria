class RoomsController < ApplicationController
  def new
    @guesthouse = Guesthouse.find(params[:guesthouse_id])
    @room = Room.new(guesthouse: @guesthouse)
  end

  def create
    guesthouse = Guesthouse.find(params[:guesthouse_id])
    room_params = params.require(:room).permit(:name, :description, :dimension,
                                               :max_people, :daily_rate,
                                               :private_bathroom, :balcony,
                                               :air_conditioning, :tv, :closet,
                                               :safe, :accessibility)
    @room = Room.new(room_params)
    @room.guesthouse = guesthouse
    @room.save
    redirect_to guesthouse, notice: 'Quarto cadastrado com sucesso'
  end
end
