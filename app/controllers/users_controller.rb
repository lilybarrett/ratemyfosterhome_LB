class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @foster_homes = @user.foster_homes
  end
end
