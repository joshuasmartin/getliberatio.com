class CreateHostedFiles < ActiveRecord::Migration
  def change
    create_table :hosted_files do |t|
      t.integer :node_id
      t.integer :organization_id
      t.text :file_name
      t.text :friendly_name
      t.text :s3_url

      t.timestamps
    end
    add_index :hosted_files, :node_id
    add_index :hosted_files, :organization_id
  end
end
