class AddReceiveEmailsBooleanColumnToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :receive_emails, :boolean
  end

  def self.down
    remove_column :user, :receive_emails
  end
end
