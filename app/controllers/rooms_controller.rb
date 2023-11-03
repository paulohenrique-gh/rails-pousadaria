class RoomsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  # TODO: Move to ApplicationController
  before_action :set_guesthouse_and_check_user, only: [:new, :create]

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

  private

  def room_params
    params.require(:room).permit(:name, :description, :dimension,
                                 :max_people, :daily_rate,
                                 :private_bathroom, :balcony,
                                 :air_conditioning, :tv, :closet,
                                 :safe, :accessibility)
  end

  def set_guesthouse_and_check_user
    @guesthouse = Guesthouse.find(params[:guesthouse_id])
    if @guesthouse.user != current_user || @guesthouse.inactive?
      redirect_to(
        root_path,
        notice: 'Você não tem autorização para alterar esta pousada'
      )
    end
  end
end
