class ApiController < ApplicationController
  
  def github_post_receive
    
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