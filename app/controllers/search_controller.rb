class SearchController < ApplicationController
  def index
    @users = User.order(last_name: :asc)
    if params[:id]
      @user = User.find_by(params[:id])
    end
  end
end
