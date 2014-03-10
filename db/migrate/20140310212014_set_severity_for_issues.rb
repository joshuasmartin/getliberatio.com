class SetSeverityForIssues < ActiveRecord::Migration
  def change
    change_column :issues, :severity,  :string, :default => "low"
  end
end
