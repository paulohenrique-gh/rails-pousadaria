class RoomsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  # TODO: Move to ApplicationController
  before_action :set_guesthouse_and_check_user, only: [:new, :create,
                                                       :edit, :update]

  def show
    @room = Room.find(params[:id])
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

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    @guesthouse = @room.guesthouse

    if @room.update(room_params)
      redirect_to(
        [@guesthouse, @room], notice: 'Quarto atualizado com sucesso'
      )
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

  def set_guesthouse_and_check_user
    @guesthouse = Guesthouse.find(params[:guesthouse_id])
    if @guesthouse.user != current_user || @guesthouse.inactive?
      redirect_to(
        root_path,
        alert: 'Você não tem autorização para alterar esta pousada'
      )
    end
  end
end
