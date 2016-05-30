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

  def update
    if current_user.admin?
      user = User.find(params[:id])
      if user.admin?
        user.admin = false
      else
        user.admin = true
      end
      user.save
      redirect_to admin_users_path
    else
      raise_error
    end
  end

  def destroy
    if current_user.admin?
      User.find(params[:id]).destroy
      redirect_to admin_users_path
    else
      raise_error
    end
  end
end
