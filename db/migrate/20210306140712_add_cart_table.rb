class AddCartTable < ActiveRecord::Migration[5.0]
  def change
    create_table :carts do |t|
      t.integer :quantity, default: 0
      t.decimal :subtotal
      t.decimal :total
      t.decimal :tax
      t.references :order, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
