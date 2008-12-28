def dispatch(request)
  request = Rack::Request.new(request)
  send(request.request_method.downcase, request) rescue nil
end

def get(request)
  [200, { "Content-Type" => "text/html" }, "hello <b>world</b>"]
end

def feed
  
end

def post(request)
  
end

site = Rack::URLMap.new()

run method(:dispatch)