class UsersController < ApplicationController
  before_action :authenticate_user

  def show
    @user = User.find(params[:id])
    if current_user == @user || current_user.admin?
      @user_active_foster_homes = @user.foster_homes.where(active: true)
      @user_inactive_foster_homes = @user.foster_homes.where(active: false)
    else
      raise_error
    end
  end
end
