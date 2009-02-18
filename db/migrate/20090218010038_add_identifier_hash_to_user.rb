class AddIdentifierHashToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :identifier_hash, :string
  end

  def self.down
    remove_column :users, :identifier_hash
  end
end
