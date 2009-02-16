require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Example do
  before(:each) do
    @valid_attributes = {
    }
  end

  it "should create a new instance given valid attributes" do
    Example.create!(@valid_attributes)
  end
end



describe "Formatting an Example's content" do
  it "should highlight Ruby source code properly" do
    markdown = <<-MARKDOWN
This is a header
----------------

Lorem ipsum dolar sit amet.

    # Ruby
    loop do
      puts "Hello world!"
    end

Danke schön.

    MARKDOWN
    
    formatted = Example.format_markdown_to_html(markdown)
    formatted.should_not include('# Ruby')
    formatted.should include('<pre class="syntax-ruby">')
    
  end
  
  it "should remove the 'RUBY:' string even if there is no <code> section following it"
  
end