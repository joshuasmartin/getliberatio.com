class AddShouldReceiveNewsletterToUsers < ActiveRecord::Migration
  def change
    add_column :users, :should_receive_newsletter, :boolean, :default => false
  end
end
