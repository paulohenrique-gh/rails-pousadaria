class ReviewsController < ApplicationController
  before_action :authenticate_guest!, only: [:new]
  before_action :set_reservation, only: [:new, :create]
  before_action :check_guest, only: [:new]

  def new
    @review = Review.new(reservation: @reservation)
  end

  def create
    @review = Review.new(review_params)
    @review.reservation = @reservation

    if @review.save
      return redirect_to guest_manage_reservation_path(@reservation),
             notice: 'Avaliação registrada com sucesso'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :description)
  end

  def set_reservation
    @reservation = Reservation.find(params[:reservation_id])
  end

  def check_guest
    redirect_to root_path if set_reservation.guest != current_guest
  end
end
