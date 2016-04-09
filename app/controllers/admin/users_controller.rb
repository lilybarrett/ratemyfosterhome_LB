class Admin::UsersController < ApplicationController
  before_action :authenticate_user

  def index
    if current_user.admin?
      if params[:search]
        @users = User.search(params[:search]).order("last_name ASC")
      else
        @users = User.all.order("last_name ASC")
      end
    else
      raise_error
    end
  end

  def update
    user = User.find(params[:id])
    if user.admin?
      user.admin = false
    else
      user.admin = true
    end
    user.save
    redirect_to admin_users_path
  end

  def show
    @user = User.find(params[:id])
    @foster_homes = @user.foster_homes
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to admin_users_path
  end
end
