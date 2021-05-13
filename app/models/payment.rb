class Payment < ApplicationRecord
  belongs_to :account
  enum status: { account: 0, cash: 1, credit: 2 }
end
