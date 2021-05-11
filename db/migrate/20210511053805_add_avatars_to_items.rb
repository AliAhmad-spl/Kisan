class AddAvatarsToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :avatars, :string
  end
end
