class Admin::UsersController < ApplicationController
  before_action :authenticate_user

  def index
    if current_user.admin?
      if params[:search]
        @user = User.find(params[:search])
        @user_active_foster_homes = @user.foster_homes.where(active: true)
        @user_inactive_foster_homes = @user.foster_homes.where(active: false)
      else
        @users = User.all.order("last_name ASC")
      end
    else
      raise_error
    end
  end

  def destroy
    if current_user.admin?
      @user = User.find(params[:id])
      @user.destroy
      flash[:notice] = "#{@user.first_name} #{@user.last_name}'s account has been removed from the site."
      redirect_to admin_users_path
    else
      raise_error
    end
  end
end
