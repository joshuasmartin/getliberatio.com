class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.integer :node_id
      t.integer :organization_id
      t.text :title
      t.text :contents
      t.integer :user_id

      t.timestamps
    end
    add_index :notes, :node_id
    add_index :notes, :organization_id
    add_index :notes, :user_id
  end
end
