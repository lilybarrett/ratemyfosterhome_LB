class FosterHomesController < ApplicationController
  before_action :authenticate_user

  def index
    @foster_homes = FosterHome.all
  end

  def show
    @foster_home = FosterHome.find(params[:id])
    @reviews = @foster_home.reviews
  end

  def new
    @foster_home = FosterHome.new
    @user_results = User.categories_for_user_dropdown
    @child_results = FosterKid.categories_for_child_dropdown
    @parent_results = FosterParent.categories_for_parent_dropdown
  end

  def create
    @foster_home = FosterHome.new(foster_home_params)
    @user = User.find(params[:foster_home][:user_id])
    if @foster_home.save
      redirect_to foster_home_path(@foster_home)
    else
      redirect_to new_foster_home_path
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
