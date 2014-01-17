class CreateInstances < ActiveRecord::Migration
  def change
    create_table :instances do |t|
      t.integer :application_id
      t.integer :node_id

      t.timestamps
    end
    add_index :instances, :application_id
    add_index :instances, :node_id
  end
end
