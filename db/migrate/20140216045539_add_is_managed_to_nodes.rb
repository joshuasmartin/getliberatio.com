class AddIsManagedToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :is_managed, :boolean, :default => true
  end
end
