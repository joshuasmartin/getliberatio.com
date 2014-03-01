class AddIsInstalledToUpdates < ActiveRecord::Migration
  def change
    add_column :updates, :is_installed, :boolean, :default => false
  end
end
