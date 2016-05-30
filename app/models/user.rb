class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :foster_kids
  has_many :foster_homes

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates_inclusion_of :admin, :in => [true, false]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_format_of :email, with: /\A[\w+\-.]+(@state.ma.us)\z/i, message: "(You need a state email address in order to register.)"

  def self.categories_for_user_dropdown
    all.map { |u| [u.last_name, u.id] }
  end

  def self.search(query)
    where("last_name LIKE ?", "%#{query}%")
  end
end
