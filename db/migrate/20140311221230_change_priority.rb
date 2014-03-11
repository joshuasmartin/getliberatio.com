class ChangePriority < ActiveRecord::Migration
  def change
    change_column :tickets, :priority,  :string
  end
end
