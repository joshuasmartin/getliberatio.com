class CreateInstallations < ActiveRecord::Migration
  def change
    create_table :installations do |t|
      t.integer :update_id
      t.integer :node_id
      t.integer :organization_id

      t.timestamps
    end
    add_index :installations, :node_id
    add_index :installations, :organization_id
    add_index :installations, :update_id
  end
end
