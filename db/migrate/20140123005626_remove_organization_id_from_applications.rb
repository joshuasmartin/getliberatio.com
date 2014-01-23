class RemoveOrganizationIdFromApplications < ActiveRecord::Migration
  def up
    remove_column :applications, :organization_id
  end
end
