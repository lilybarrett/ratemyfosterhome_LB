class DataController < ApplicationController
  def display_data
    @foster_home = FosterHome.find(params[:id])
    @foster_kid_reviews = @foster_home.foster_kid_reviews
    @foster_parent_reviews = @foster_home.foster_parent_reviews
    @social_worker_reviews = @foster_home.social_worker_reviews
    @all_home_reviews = []
    @all_home_reviews =
      @foster_kid_reviews + @foster_parent_reviews + @social_worker_reviews
    @all_home_reviews_by_date =
      @all_home_reviews.group_by_day { |review| review.created_at }
    @dates = @all_home_reviews_by_date.keys.strftime("%m/%d/%Y")
  end
end
