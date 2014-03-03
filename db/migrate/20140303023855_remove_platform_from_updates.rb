class RemovePlatformFromUpdates < ActiveRecord::Migration
  def change
    remove_column :updates, :platform
  end
end
