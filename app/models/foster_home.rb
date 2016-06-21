class FosterHome < ActiveRecord::Base
  belongs_to :foster_kid
  belongs_to :foster_parent
  belongs_to :user

  has_many :foster_kid_reviews
  has_many :foster_parent_reviews
  has_many :social_worker_reviews
  has_many :social_worker_case_comments 

  validates_inclusion_of :active, :in => [true, false]

end
