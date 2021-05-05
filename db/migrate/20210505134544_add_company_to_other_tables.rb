class AddCompanyToOtherTables < ActiveRecord::Migration[5.0]
  def change
  	add_column :orders, :company_id, :integer
  	add_column :users, :company_id, :integer
  	add_column :items, :company_id, :integer
  end
end
