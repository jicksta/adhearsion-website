class PageController < ApplicationController
  
  def index
    @title = "Open-Source Telephony Development Framework"
    @blog_posts = load_blog_posts_from_aggregator
    
  end
  
  def getting_started
    @title = "Getting Started"
    @user = User.new
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
