class Item < ApplicationRecord
  WHITELIST_PARAMS = %i[
    name
    category
    quantity
    price
    description
    company_id
    remaining_quantity
  ].freeze
  has_many :line_items
  # has_many :members, through: :orders
  belongs_to :company
  validates :name, :price, presence: true
  validates :category, presence: true
end
