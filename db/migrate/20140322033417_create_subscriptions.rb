class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :organization_id

      t.timestamps
    end
  end
end
