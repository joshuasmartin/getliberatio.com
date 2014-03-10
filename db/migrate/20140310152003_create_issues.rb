class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.integer :organization_id
      t.integer :node_id
      t.string :title
      t.string :severity

      t.timestamps
    end
  end
end
