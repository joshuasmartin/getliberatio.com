class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.string :role
      t.text :location
      t.string :name
      t.string :operating_system
      t.string :serial_number
      t.string :model_number
      t.integer :organization_id

      t.timestamps
    end
  end
end
