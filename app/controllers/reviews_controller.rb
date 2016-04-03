class ReviewsController < ApplicationController
  before_action :authenticate_user

  def new
    @foster_home = FosterHome.find(params[:foster_home_id])
    @review = Review.new
  end

  def create
    @foster_home = FosterHome.find(params[:foster_home_id])
    @review = @foster_home.reviews.new(review_params)
    @review.user = current_user
    if @review.save
      # ReviewMailer.new_review(@review).deliver_later
      redirect_to foster_home_path(@foster_home)
    else
      flash[:errors] = @review.errors.full_messages.join(". ")
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(
      :rating,
      :comment,
      :type_id 
    )
  end
end
