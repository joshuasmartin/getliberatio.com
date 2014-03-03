class UpgradeUpdates < ActiveRecord::Migration
  def change
    remove_column :updates, :severity

    add_column :updates, :severity, :string
    add_column :updates, :support_url, :string
  end
end
