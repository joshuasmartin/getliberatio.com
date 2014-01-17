class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email_address
      t.string :name
      t.string :password_digest
      t.string :role
      t.integer :organization_id

      t.timestamps
    end
    add_index :users, :organization_id
  end
end
