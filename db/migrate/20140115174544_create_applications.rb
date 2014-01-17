class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.string :name
      t.string :publisher
      t.string :version
      t.integer :organization_id

      t.timestamps
    end
    add_index :applications, :organization_id
  end
end
