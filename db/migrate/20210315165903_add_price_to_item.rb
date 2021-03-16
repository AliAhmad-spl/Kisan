class AddPriceToItem < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :price, :integer, null: false, default: 0
  end
end
