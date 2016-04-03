class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :foster_kids
  has_many :foster_homes, through: :foster_kids

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates_inclusion_of :admin, :in => [true, false]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.categories_for_user_dropdown
    all.map { |u| [u.last_name, u.id] }
  end
end
