class AddRegistrationCodeToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :registration_code, :string
  end
end
