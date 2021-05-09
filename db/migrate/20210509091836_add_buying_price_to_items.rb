class AddBuyingPriceToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :buying_price, :integer
    add_column :items, :expiry_date, :date
  end
end
