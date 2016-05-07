class HomeController < ApplicationController
  def show
    @user_results = User.categories_for_user_dropdown
    @foster_home = FosterHome.new
    @child_results = FosterKid.categories_for_child_dropdown
    @parent_results = FosterParent.categories_for_parent_dropdown

    @foster_kid = FosterKid.new
    @foster_parent = FosterParent.new
  end
end
