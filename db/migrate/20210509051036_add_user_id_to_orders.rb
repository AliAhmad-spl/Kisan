class AddUserIdToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :user_id, :integer
    remove_column :orders, :member_id, :integer
  end
end
