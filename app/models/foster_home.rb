class FosterHome < ActiveRecord::Base
  belongs_to :foster_kid
  belongs_to :foster_parent
  belongs_to :user

  validates_inclusion_of :active, :in => [true, false]
end
