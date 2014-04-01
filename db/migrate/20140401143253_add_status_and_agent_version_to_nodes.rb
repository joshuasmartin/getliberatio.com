class AddStatusAndAgentVersionToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :status, :string, :default => "offline"
    add_column :nodes, :agent_version, :string
  end
end
