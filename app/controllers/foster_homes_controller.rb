class FosterHomesController < ApplicationController
  before_action :authenticate_user

  def index
    @active_foster_homes = FosterHome.where(active: true)
    @inactive_foster_homes = FosterHome.where(active: false)
  end

  def show
    @foster_home = FosterHome.find(params[:id])
    @foster_kid = @foster_home.foster_kid
    @foster_parent = @foster_home.foster_parent
    @foster_kid_reviews = @foster_home.foster_kid_reviews
    @foster_parent_reviews = @foster_home.foster_parent_reviews
    @social_worker_reviews = @foster_home.social_worker_reviews
    @all_home_reviews = []
    @all_home_reviews =
      @foster_kid_reviews + @foster_parent_reviews + @social_worker_reviews
    @all_home_reviews_by_date =
      @all_home_reviews.group_by_day { |review| review.created_at }
    @all_home_reviews_by_date.delete_if { |k,v| v.empty? }
    # @data = []
    # @all_home_reviews.each { |review| @data << review.rating }
    # @dates = @all_home_reviews_by_date.keys.map! { |date| date.strftime("%m/%d/%Y") }
  end

  def new
    @foster_home = FosterHome.new
    @user_results = User.categories_for_user_dropdown
    @child_results = FosterKid.categories_for_child_dropdown
    @parent_results = FosterParent.categories_for_parent_dropdown
  end

  def create
    #if foster_home with selected kid already exists AND is active, do not create the home, raise an error.
    @foster_home = FosterHome.new(foster_home_params)
    @foster_kid = FosterKid.find(params[:foster_home][:foster_kid_id])
    unless FosterHome.exists?(foster_kid_id: @foster_kid)
      if @foster_home.save
        redirect_to foster_home_path(@foster_home)
      else
        redirect_to new_foster_home_path
      end
    else
      flash[:notice] = "This foster youth has already been assigned to a case."
      redirect_to root_path
    end
  end

  def edit
    @foster_home = FosterHome.find(params[:id])
    @user_results = User.categories_for_user_dropdown
  end

  def update
    @foster_home = FosterHome.find(params[:id])
    if @foster_home.update_attributes(foster_home_params)
      flash[:notice] = "Foster Home information successfully updated"
      redirect_to foster_home_path(@foster_home)
    else
      flash[:error] = "Please fill out all required fields."
      render :edit
    end
  end

  def unassign
    @foster_home = FosterHome.find(params[:id])
    @foster_home.user_id = nil
    if @foster_home.save!
      flash[:notice] = "This case has been successfully unassigned."
      redirect_to foster_home_path(@foster_home)
    else
      flash[:error] = "Error!"
      redirect_to foster_home_path(@foster_home)
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
