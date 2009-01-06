class CreateSandboxUsers < ActiveRecord::Migration
  def self.up
    create_table :sandbox_users do |t|
      t.string :name
      t.string :email
      t.string :password_hash
      t.string :identifier_hash
      t.boolean :receive_emails

      t.timestamps
    end
  end

  def self.down
    drop_table :sandbox_users
  end
end
