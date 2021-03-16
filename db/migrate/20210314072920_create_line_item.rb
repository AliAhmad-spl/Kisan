class CreateLineItem < ActiveRecord::Migration[5.0]
  def change
    create_table :line_items do |t|
      t.integer :quantity, default: 0
      t.integer :price, default: 0
      t.float :sub_total, default: 0
      t.references :item, foreign_key: true
      t.references :cart, foreign_key: true
    end
  end
end
