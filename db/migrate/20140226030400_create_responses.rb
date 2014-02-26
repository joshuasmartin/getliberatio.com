class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :ticket_id
      t.text :content
      t.integer :user_id

      t.timestamps
    end
  end
end
