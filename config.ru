require 'active_support'
require 'ostruct'

THIS_DIRECTORY = File.dirname __FILE__

BUCKET = []

PAGES = Dir.glob(THIS_DIRECTORY + "/pages/*.html").inject({}) do |url_map, filename|
  page_name = "/" + File.basename(filename, ".html")
  url_map[page_name] = lambda do |env|
    render_page(env, filename)
  end
  url_map
end

def layout
  File.read THIS_DIRECTORY + "/index.html"
end

def blog_content
  YAML.load_file(THIS_DIRECTORY + "/blog.yml").map do |blog_post|
    content = blog_post["content"]
    content = "<p>#{content}</p>"
    blog_post["content"] = content.gsub "\n", "</p><p>"
    blog_post
  end
end

def feed_content
  blog_content.map do |feed_item|
    feed_item.delete 'slug'
    feed_item["updated"] = Time.parse(feed_item["updated"]).xmlschema
    feed_item["id"] = "urn:uri:#{feed_item.delete 'uuid'}"
    # feed_item["link"] = x"http://adhearsion.com/#{feed_item['id']}"
    feed_item
  end
end

def html(body, headers={})
  [200, { "Content-Type" => "text/html" }.merge(headers), body]
end

def feed(env)
  xml = %<<?xml version="1.0" encoding="utf-8"?>
    <feed xmlns="http://www.w3.org/2005/Atom">

      <title>Adhearsion News</title>
      <subtitle>News about Adhearsion, the open-source voice application development framework.</subtitle>
      <link href="http://adhearsion.com/feed" rel="self"/>
      <updated>2003-12-13T18:30:02Z</updated>
      <id>http://adhearsion.com/</id>
      <author>
        <name>Jay Phillips</name>
      </author>
  
      %s
  
    </feed>>
    
    entries = feed_content.map do |obj|
      obj.to_xml(:skip_instruct => true, :skip_types => true, :root => "entry")
    end.join("\n\n")
    
  [200, {"Content-Type" => "application/atom+xml"}, xml % entries]
end

def render_page(env, filename)
  page_name = File.basename(filename, ".html")
  page_contents = File.read filename
  html layout % page_contents
end

def dispatch(request)
  request = Rack::Request.new(request)
  send(request.request_method.downcase, request) rescue nil
end

def homepage(env)
  return [404, {}, ""] if env["PATH_INFO"] != "/"
  blog_posts = blog_content.map do |blog_post|
    blog_post = OpenStruct.new(blog_post)
    <<-HTML
      <div class="blog_post">
        <h1>#{blog_post.title}</h1>
        <p class="meta">#{Time.parse(blog_post.updated).strftime("%B %d, %Y")}</p>
        #{blog_post.content}
      </div>
    HTML
  end
  html layout % blog_posts.join("\n\n")
end

def github_api(env)
  request = Rack::Request.new(env)
  BUCKET << 
  if request.post?
    payload = JSON.parse(URI.unescape(env["rack.input"].read))["payload"]
  end
end

def view_bucket(env)
  [200, {"Content-Type" => "text/plain"}, BUCKET.pretty_inspect]
end

pages = Rack::URLMap.new(PAGES)

dynamic = Rack::URLMap.new \
    "/feed"       => method(:feed),
    "/github_api" => method(:github_api)
    "/bucket"     => method(:view_bucket)

cascade = Rack::Cascade.new([method(:homepage), dynamic, pages])

site = Rack::Static.new(cascade, :root => "public", :urls => ["/images", "/css"])

run site