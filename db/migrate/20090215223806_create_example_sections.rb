class CreateExampleSections < ActiveRecord::Migration
  def self.up
    create_table :example_sections do |t|
      t.integer :position
      t.string :title
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :example_sections
  end
end
