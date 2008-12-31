class PageController < ApplicationController
  
  def index
    @blog_posts = BlogPost.find :all
  end
  
  def architecture
    @title = "Architecture Overview"
  end
  
  def business_case
    @title = "The Business Case"
  end
  
  def consulting
    @title = "Consulting"
  end
  
  def contact
    @title = "Contact Us"
  end
  
  def contributing
    @title = "Contributing"
  end
  
  def download
    @title = "Download Adhearsion"
  end
  
  def examples
    @title = "Examples"
  end
  
  def faq
    @title = "Frequently Asked Questions"
  end
  
  def getting_started
    @title = "Getting Started"
  end
  
  def irc
    @title = "IRC Chatroom"
  end
  
  def roadmap
    @title = "Roadmap"
  end
  
  def screencasts
    @title = "Screencasts"
  end
  
end
