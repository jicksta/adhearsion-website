
def feed_content
  blog_content.map do |feed_item|
    feed_item.delete 'slug'
    feed_item["updated"] = Time.parse(feed_item["updated"]).xmlschema
    feed_item["id"] = "urn:uri:#{feed_item.delete 'uuid'}"
    # feed_item["link"] = x"http://adhearsion.com/#{feed_item['id']}"
    feed_item
  end
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

def github_api(env)
  request = Rack::Request.new(env)
  payload = JSON.parse request.POST["payload"]
  BUCKET << payload
  `git checkout .; git pull`
  html "ok"
  # if request.post?
  #   payload = JSON.parse(env["rack.input"].read)
  # end
end

dynamic = Rack::URLMap.new \
    "/feed"       => method(:feed),
    "/github_api" => method(:github_api),
