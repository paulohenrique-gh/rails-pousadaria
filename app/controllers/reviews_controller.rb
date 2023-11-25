class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:user_reviews, :respond, :save_response]
  before_action :authenticate_guest!, only: [:new, :create]
  before_action :set_reservation, only: [:new, :create]
  before_action :check_guest, only: [:new, :create]
  before_action :redirect_new_host_to_guesthouse_creation, only: [:user_reviews]

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
      flash.now[:alert] = 'Não foi possível registrar a avaliação'
      render :new, status: :unprocessable_entity
    end
  end

  def user_reviews
    @reviews = current_user.guesthouse.reviews
  end

  def respond
    @review = Review.find(params[:id])
    redirect_to user_reviews_path if @review.response.present?
  end

  def save_response
    @review = Review.find(params[:id])
    return redirect_to root_path unless @review.guesthouse.user == current_user

    @review.response = params[:review][:response]

    if @review.save
      redirect_to user_reviews_path, notice: 'Resposta registrada com sucesso'
    else
      render :respond, status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :description, :response)
  end

  def set_reservation
    @reservation = Reservation.find(params[:reservation_id])
  end

  def check_guest
    redirect_to root_path if set_reservation.guest != current_guest
  end
end
