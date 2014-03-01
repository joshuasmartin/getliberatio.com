class DropUpdatesCreateUpdates < ActiveRecord::Migration
  def up
    drop_table :installations
    drop_table :updates

    create_table :updates do |t|
      t.string :title
      t.string :platform
      t.integer :severity, :default => 10
      t.integer :organization_id
      t.integer :node_id
    end
    add_index :updates, :organization_id
    add_index :updates, :node_id
  end
end
