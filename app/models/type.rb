class Type < ActiveRecord::Base
  has_many :reviews

  validates :type_name, presence: true
  validates :question, presence: true 
end
