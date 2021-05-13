class AddTotalsToAccounts < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :total_credit, :integer, default: 0
    add_column :accounts, :total_debit, :integer, default: 0
    add_column :accounts, :remaining_balance, :integer, default: 0
  end
end
