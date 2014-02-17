class AddInventoriedAtToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :inventoried_at, :datetime
  end
end
