class Account < ApplicationRecord
  has_many :payments
  belongs_to :company
end
