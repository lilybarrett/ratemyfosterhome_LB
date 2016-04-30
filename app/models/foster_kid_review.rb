class FosterKidReview < ActiveRecord::Base
  belongs_to :user
  belongs_to :foster_home

  validates :rating, presence: true, numericality: {
    only_integer: true
  }
  validates :comment, presence: true

  validates :user_id, presence: true
  validates :foster_home_id, presence: true
end
