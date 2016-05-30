class HomeController < ApplicationController
  before_action :authenticate_user

  def show
    if current_user.admin?
      @foster_home = FosterHome.new
      @foster_kid = FosterKid.new
      @foster_parent = FosterParent.new
      @user_results = User.categories_for_user_dropdown
      @child_results = FosterKid.categories_for_child_dropdown
      @parent_results = FosterParent.categories_for_parent_dropdown
    else
      @user = current_user
      @user_active_foster_homes = @user.foster_homes.where(active: true)
      @user_inactive_foster_homes = @user.foster_homes.where(active: false)
    end
  end
end
