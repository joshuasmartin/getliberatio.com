class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer :organization_id
      t.integer :priority
      t.string :status
      t.string :category
      t.text :description

      t.timestamps
    end
    add_index :tickets, :organization_id
  end
end
