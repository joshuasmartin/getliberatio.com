class AddUuidToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :uuid, :string
    add_index :nodes, :organization_id
  end
end
