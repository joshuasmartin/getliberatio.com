class AddOrganizationIdToInstances < ActiveRecord::Migration
  def change
    add_column :instances, :organization_id, :integer
  end
end
