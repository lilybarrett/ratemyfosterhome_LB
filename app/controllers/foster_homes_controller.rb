class FosterHomesController < ApplicationController
  before_action :authenticate_user

  def index
    @foster_homes = FosterHome.all
  end

  def show
    @foster_home = FosterHome.find(params[:id])
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

  # def edit
  # end
  #
  # def update
  # end
  #
  # def destroy
  # end

  private

  def foster_home_params
    params.require(:foster_home).permit(
      :foster_kid_id,
      :foster_parent_id,
      :user_id
    )
  end
end
