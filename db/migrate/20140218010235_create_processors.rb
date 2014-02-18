class CreateProcessors < ActiveRecord::Migration
  def change
    create_table :processors do |t|
      t.integer :node_id
      t.string :architecture
      t.string :name
      t.string :cores_count
      t.string :speed

      t.timestamps
    end
  end
end
