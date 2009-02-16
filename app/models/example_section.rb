class ExampleSection < ActiveRecord::Base
  
  has_many :examples, :order => "position"
  
  acts_as_list
  
  validates_presence_of :title
  
  before_save :generate_description_html
  
  protected
  
  def generate_description_html
    return if description.blank?
    self.description_html = BlueCloth.new(description).to_html
  end
  
end
