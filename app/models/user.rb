class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  enum roles: { admin: 0, salesman: 1, manager: 2 }

  has_many :orders
  has_many :items, through: :orders

  validates :name, presence: true
  validates :email, presence: true
  # validates :phone, presence: true

  def admin?
    role == 0
  end
end