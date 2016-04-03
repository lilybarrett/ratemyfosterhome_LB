class FosterParent < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :foster_homes
  has_many :foster_kids, through: :foster_homes

  def self.categories_for_parent_dropdown
    all.map { |u| [u.last_name, u.id] }
  end
end
