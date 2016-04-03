class FosterParent < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :foster_homes
  has_many :foster_kids, through: :foster_homes
end
