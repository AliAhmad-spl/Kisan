class AddCompanyNameToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :company_name, :string
    add_column :users, :address, :string
  end
end
