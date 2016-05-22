class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @user_active_foster_homes = @user.foster_homes.where(active: true)
    @user_inactive_foster_homes = @user.foster_homes.where(active: false)
  end
end
