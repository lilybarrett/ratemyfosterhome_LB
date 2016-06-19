class FosterHomesController < ApplicationController
  before_action :authenticate_user

  def index
    if current_user.admin?
      @active_foster_homes = FosterHome.where(active: true).includes(:foster_kid).order("foster_kids.last_name")
      @inactive_foster_homes = FosterHome.where(active: false).includes(:foster_kid).order("foster_kids.last_name")
    else
      raise_error
    end
  end

  def show
    @foster_home = FosterHome.find(params[:id])
    if current_user.admin? || @foster_home.user == current_user
      @foster_kid = @foster_home.foster_kid
      @foster_parent = @foster_home.foster_parent
      @foster_kid_reviews = @foster_home.foster_kid_reviews
      @foster_parent_reviews = @foster_home.foster_parent_reviews
      @social_worker_reviews = @foster_home.social_worker_reviews
      @all_home_reviews =
        @foster_kid_reviews + @foster_parent_reviews + @social_worker_reviews
      @all_home_reviews_by_date =
        @all_home_reviews.group_by_day { |review| review.created_at }
      @all_home_reviews_by_date.delete_if { |date, review| review.empty? }
      @series_a = @foster_kid_reviews.map { |r| [r.created_at.strftime("%m/%d/%Y"), r.rating] }.to_h
      @series_b = @foster_parent_reviews.map { |r| [r.created_at.strftime("%m/%d/%Y"), r.rating] }.to_h
      @series_c = @social_worker_reviews.map { |r| [r.created_at.strftime("%m/%d/%Y"), r.rating] }.to_h
    else
      raise_error
    end
  end

  def new
    if current_user.admin?
      @foster_home = FosterHome.new
      @user_results = User.categories_for_user_dropdown
      @child_results = FosterKid.categories_for_child_dropdown
      @parent_results = FosterParent.categories_for_parent_dropdown
    else
      raise_error
    end
  end

  def create
    if current_user.admin?
      @foster_home = FosterHome.new(foster_home_params)
      @foster_kid = FosterKid.find(params[:foster_home][:foster_kid_id])
      unless FosterHome.exists?(foster_kid_id: @foster_kid, active: true)
        if @foster_home.save
          redirect_to foster_home_path(@foster_home)
        else
          redirect_to new_foster_home_path
        end
      else
        flash[:notice] = "This foster youth has already been assigned to an active case."
        redirect_to authenticated_root_path
      end
    else
      raise_error
    end
  end

  def edit
    if current_user.admin?
      @foster_home = FosterHome.find(params[:id])
      @user_results = User.categories_for_user_dropdown
    else
      raise_error
    end
  end

  def update
    if current_user.admin?
      @foster_home = FosterHome.find(params[:id])
      if @foster_home.update_attributes(foster_home_params)
        flash[:notice] = "Foster Home information successfully updated"
        redirect_to foster_home_path(@foster_home)
      else
        flash[:error] = "Please fill out all required fields."
        render :edit
      end
    else
      raise_error
    end
  end

  def unassign
    if current_user.admin?
      @foster_home = FosterHome.find(params[:id])
      @foster_home.user_id = nil
      if @foster_home.save!
        flash[:notice] = "This case has been successfully unassigned."
        redirect_to foster_home_path(@foster_home)
      else
        flash[:error] = "Error!"
        redirect_to foster_home_path(@foster_home)
      end
    else
      raise_error
    end
  end

  def thank_you
    @foster_home = FosterHome.find(params[:id])
    @foster_kid = @foster_home.foster_kid
    @foster_parent = @foster_home.foster_parent
    if current_user.admin? || current_user == @foster_home.user
      render :thank_you
    end
  end

  private

  def foster_home_params
    params.require(:foster_home).permit(
      :active,
      :foster_kid_id,
      :foster_parent_id,
      :user_id
    )
  end
end
