class Example < ActiveRecord::Base

  class << self
    
    ##
    # Implements a superset of the Markdown syntax to enable code syntax highlighting.
    #
    def format_markdown_to_html(content)
      rendered = BlueCloth.new(content).to_html
      if rendered.include?('# Ruby')
        begin
          xml_document = XML::Parser.string("<example>#{rendered}</example>").parse
          code_elements = xml_document.find "//code"
          if code_elements.any?
            code_elements.each do |element|            
              if element.content =~ /^\s*# Ruby/
                element.content = element.content.sub(/# Ruby\n+/, "")
                formatted_ruby = ruby_to_html element.content
                formatted_ruby_element = XML::Parser.string("#{formatted_ruby}").parse
                formatted_ruby_element.root.children.each do |child|
                  element.parent << child.copy(true)
                end
                element.parent["class"] = "syntax-ruby"
                element.remove!
              end
            end
          end
          xml_document.root.children.to_s :indent => true
        rescue XML::Parser::ParseError
          rendered
        end
      else
        rendered
      end
    end
    
    def ruby_to_html(ruby)
      Syntax::Convertors::HTML.for_syntax("ruby").convert(ruby)
    end
    
  end
  
  validates_presence_of :title, :content, :example_section_id
  
  belongs_to :example_section
  
  acts_as_list :scope => "example_section_id"
  
  before_save :generate_content_html
  
  protected
  
  def generate_content_html
    return if content.blank?
    self.content_html = self.class.format_markdown_to_html content
  end
  
  
end
