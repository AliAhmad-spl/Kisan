class Order < ApplicationRecord
  has_one :cart, dependent: :destroy
  has_many :line_items
  belongs_to :user
  belongs_to :company

  # validates :quantity, presence: true
  # validates :expire_at, presence: true
  # validates :item_id, presence: true
  #validates :member_id, presence: true
  enum status: {account: 0, cash: 1, credit: 2}
end
