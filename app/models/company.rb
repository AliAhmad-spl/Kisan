class Company < ApplicationRecord
  has_many :users
  has_many :orders
  has_many :items
  has_many :members
  has_many :carts
end
