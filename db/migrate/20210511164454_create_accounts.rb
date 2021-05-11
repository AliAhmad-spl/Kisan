class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.string :party_name
      t.integer :company_id

      t.timestamps
    end
  end
end
