class CreateDisks < ActiveRecord::Migration
  def change
    create_table :disks do |t|
      t.integer :node_id
      t.string :disk_type
      t.string :file_system
      t.string :free_bytes
      t.string :total_bytes
      t.string :volume_name

      t.timestamps
    end
    add_index :disks, :node_id
  end
end
