class FosterParentReviewsController < ApplicationController
  before_action :authenticate_user

  def new
    @foster_home = FosterHome.find(params[:foster_home_id])
    if current_user.admin? || current_user == @foster_home.user
      @foster_parent_review = FosterParentReview.new
    else
      raise_error
    end
  end

  def create
    @foster_home = FosterHome.find(params[:foster_home_id])
    if current_user.admin? || current_user == @foster_home.user
      @foster_parent_review = @foster_home.foster_parent_reviews.new(foster_parent_review_params)
      @foster_parent_review.user = current_user
      if @foster_parent_review.save
        # ReviewMailer.new_review(@review).deliver_later
        redirect_to foster_homes_thank_you_path(@foster_home)
      else
        flash[:errors] = @foster_parent_review.errors.full_messages.join(". ")
        render :new
      end
    else
      raise_error
    end
  end

  private

  def foster_parent_review_params
    params.require(:foster_parent_review).permit(
      :rating,
      :comment
    )
  end
end
