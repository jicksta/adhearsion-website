class AddUsernameToSandboxUser < ActiveRecord::Migration
  def self.up
    add_column :sandbox_users, :username, :string
  end

  def self.down
    remove_column :sandbox_users, :username
  end
end
