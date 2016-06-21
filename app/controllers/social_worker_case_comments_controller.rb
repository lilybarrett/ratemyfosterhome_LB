class SocialWorkerCaseCommentsController < ApplicationController
  before_action :authenticate_user

  def new
    @foster_home = FosterHome.find(params[:foster_home_id])
    if current_user.admin? || current_user == @foster_home.user
      @social_worker_case_comment = SocialWorkerCaseComment.new
    else
      raise_error
    end
  end

  def create
    @foster_home = FosterHome.find(params[:foster_home_id])
    if current_user.admin? || current_user == @foster_home.user
      @social_worker_case_comment = @foster_home.social_worker_case_comments.new(social_worker_case_comment_params)
      @social_worker_case_comment.user = current_user
      if @social_worker_case_comment.save
      redirect_to foster_home_path(@foster_home)
      else
        flash[:errors] = @social_worker_case_comment.errors.full_messages.join(". ")
        render :new
      end
    else
      raise_error
    end
  end

  private

  def social_worker_case_comment_params
    params.require(:social_worker_case_comment).permit(
      :comment
    )
  end
end
