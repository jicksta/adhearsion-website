class AdminController < ApplicationController
  
  protect_from_forgery :except => [:reorder_sections, :reorder_examples] 
  
  def sections
    @example_sections = ExampleSection.find :all
  end
  
  def examples
    @example_sections = ExampleSection.find :all
  end
  
  def reorder_sections
    sections = params[:order]
    sections.split(",").each_with_index do |section, index|
      ExampleSection.find(section).update_attribute "position", index
    end
    render :text => "ok"
  end
  
  def reorder_examples
    sections = params[:order]
    sections.split(",").each_with_index do |section, index|
      Example.find(section).update_attribute "position", index
    end
    render :text => "ok"
  end
  
end
