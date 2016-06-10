class SocialWorkerReviewsController < ApplicationController
  before_action :authenticate_user

  def new
    @foster_home = FosterHome.find(params[:foster_home_id])
    if current_user.admin? || current_user == @foster_home.user
      @social_worker_review = SocialWorkerReview.new
    else
      raise_error
    end
  end

  def create
    @foster_home = FosterHome.find(params[:foster_home_id])
    if current_user.admin? || current_user == @foster_home.user 
      @social_worker_review = @foster_home.social_worker_reviews.new(social_worker_review_params)
      @social_worker_review.user = current_user
      if @social_worker_review.save
        # ReviewMailer.new_review(@review).deliver_later
        redirect_to foster_homes_thank_you_path(@foster_home)
      else
        flash[:errors] = @social_worker_review.errors.full_messages.join(". ")
        render :new
      end
    else
      raise_error
    end
  end

  private

  def social_worker_review_params
    params.require(:social_worker_review).permit(
      :rating,
      :comment
    )
  end
end
