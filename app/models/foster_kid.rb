class FosterKid < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true

  belongs_to :user
  has_many :foster_homes
  has_many :foster_parents, through: :foster_homes 

  def self.categories_for_child_dropdown
    all.map { |u| [u.last_name, u.id] }
  end
end
