class AddTokenAndTokenCreatedAtToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :token, :text
    add_column :nodes, :token_created_at, :datetime
  end
end
