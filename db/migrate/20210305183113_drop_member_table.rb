class DropMemberTable < ActiveRecord::Migration[5.0]
  def up
    drop_table :members
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
