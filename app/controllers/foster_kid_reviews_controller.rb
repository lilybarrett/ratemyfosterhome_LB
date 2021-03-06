class FosterKidReviewsController < ApplicationController
  before_action :authenticate_user

  def new
    @foster_home = FosterHome.find(params[:foster_home_id])
    if current_user.admin? || @foster_home.user == current_user
      @foster_kid_review = FosterKidReview.new
    else
      raise_error
    end
  end

  def create
    @foster_home = FosterHome.find(params[:foster_home_id])
    if current_user.admin? || @foster_home.user == current_user
      @foster_kid_review = @foster_home.foster_kid_reviews.new(foster_kid_review_params)
      @foster_kid_review.user = current_user
      if @foster_kid_review.save
        # ReviewMailer.new_review(@review).deliver_later
        redirect_to foster_homes_thank_you_path(@foster_home)
      else
        flash[:errors] = @foster_kid_review.errors.full_messages.join(". ")
        render :new
      end
    else
      raise_error
    end
  end

  private

  def foster_kid_review_params
    params.require(:foster_kid_review).permit(
      :rating,
      :comment
    )
  end
end
