class RemoveBlogPosts < ActiveRecord::Migration
  def self.up
    drop_table :blog_posts
  end

  def self.down
  end
end
