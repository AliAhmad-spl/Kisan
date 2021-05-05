class AddMoreFieldsToCompanies < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :address, :string
    add_column :companies, :contact, :string
  end
end
