class UsersController < ApplicationController
  before_action :authenticate_user

  def show
    @user = User.find(params[:id])
    if current_user == @user || current_user.admin?
      @user_active_foster_homes = @user.foster_homes.where(active: true).includes(:foster_kid).order("foster_kids.last_name")
      @user_inactive_foster_homes = @user.foster_homes.where(active: false).includes(:foster_kid).order("foster_kids.last_name")
    else
      raise_error
    end
  end

  def update_status
    @user = User.find(params[:id])
    if current_user.admin?
      if @user.admin?
        @user.update_attribute :admin, false
      else
        @user.update_attribute :admin, true
      end
      if @user.save
        if @user.admin == true
          flash[:notice] = "#{@user.first_name} #{@user.last_name} now has admin access."
          redirect_to admin_users_path
        else
          flash[:notice] = "#{@user.first_name} #{@user.last_name} has been removed from Admins."
          redirect_to admin_users_path
        end
      else
        raise_error
      end
    end
  end

end
