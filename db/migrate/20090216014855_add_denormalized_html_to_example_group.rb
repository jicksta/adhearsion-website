class AddDenormalizedHtmlToExampleGroup < ActiveRecord::Migration
  def self.up
    add_column :example_sections, :description_html, :text
  end

  def self.down
    remove_column :example_sections, :description_html
  end
end
