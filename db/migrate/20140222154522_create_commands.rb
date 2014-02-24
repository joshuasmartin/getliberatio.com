class CreateCommands < ActiveRecord::Migration
  def change
    create_table :commands do |t|
      t.integer :node_id
      t.text :executable
      t.text :arguments
      t.text :output

      t.timestamps
    end
    add_index :commands, :node_id
  end
end
