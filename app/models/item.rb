class Item < ApplicationRecord
  WHITELIST_PARAMS = %i[
    name
    category
    quantity
    price
    description
    company_id
    remaining_quantity
    avatar
  ].freeze
  mount_uploaders :avatars, AvatarUploader
  serialize :avatars, JSON
  has_many :line_items, dependent: :destroy
  # has_many :members, through: :orders
  belongs_to :company
  validates :name, :price, presence: true
  validates :category, presence: true
end
