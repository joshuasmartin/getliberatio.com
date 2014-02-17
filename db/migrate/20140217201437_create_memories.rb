class CreateMemories < ActiveRecord::Migration
  def change
    create_table :memories do |t|
      t.integer :node_id
      t.string :capacity
      t.string :form_factor
      t.string :manufacturer
      t.string :memory_type
      t.string :speed

      t.timestamps
    end
  end
end
