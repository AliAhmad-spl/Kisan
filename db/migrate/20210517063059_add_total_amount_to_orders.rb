class AddTotalAmountToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :total_amount, :integer, default: 0
  end
end
