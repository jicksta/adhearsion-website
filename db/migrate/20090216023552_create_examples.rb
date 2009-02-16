class CreateExamples < ActiveRecord::Migration
  def self.up
    create_table :examples do |t|
      t.string :title
      t.text :content
      t.text :content_html
      t.integer :position
      t.integer :example_section_id

      t.timestamps
    end
  end

  def self.down
    drop_table :examples
  end
end
