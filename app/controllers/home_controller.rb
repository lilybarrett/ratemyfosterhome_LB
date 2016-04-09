class HomeController < ApplicationController
  def show
    @user_results = User.categories_for_user_dropdown
  end
end
