class ApiController < ApplicationController
  
  def github_post_receive
    
  end
  
  def sandbox_test
    socket = TCPSocket.new('localhost', 20_000)
    socket.sync = true

    socket.print "agi_sandbox: testing123\n\n"
    socket.print "200 result=1 (sandbox_test)\n"
    socket.print "SANDBOX TEST\n"
    socket.close
    
    render :text => "sent"
  end
  
  def username_from_md5
    identifier_hash = params[:identifier_hash]
    if identifier_hash
      if user = User.find_by_identifier_hash(identifier_hash)
        render :text => user.login
      else
        render :text => "Not found!", :status => 404
      end
    else
      render :text => "You must supply an identifier hash!", :status => 404
    end
  end
  
end