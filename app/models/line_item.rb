class LineItem < ApplicationRecord
  belongs_to :cart
  belongs_to :item
  belongs_to :order
  # has_many :members, through: :orders

  # validates :name, presence: true
  # validates :category, presence: true
end
