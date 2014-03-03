class SetDefaultForTicketsStatus < ActiveRecord::Migration
  def change
    change_column_default(:tickets, :status, "Open")
  end
end
