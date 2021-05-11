class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.references :account, foreign_key: true
      t.string :customer_name
      t.integer :amount, default: 0
      t.integer :status, default: 0
      t.integer :current_balance, default: 0

      t.timestamps
    end
  end
end
