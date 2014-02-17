class AddArchitectureAndServicePackUpdateLevelToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :architecture, :string
    add_column :nodes, :service_pack_update_level, :string
  end
end
