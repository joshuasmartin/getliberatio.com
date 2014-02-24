class AddKindToCommands < ActiveRecord::Migration
  def change
    add_column :commands, :kind, :string
  end
end
