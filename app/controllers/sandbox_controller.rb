class SandboxController < ApplicationController
  
  def register_user
    if params["confirm_password"] != params["sandbox_user"]["password"]
      render :text => '{password: ["differs from confirmation"]}', :status => 500, :content_type => "text/x-json"
      return
    end
    user = SandboxUser.new params["sandbox_user"]
    if user.save
      render :text => user.to_json, :content_type => "text/x-json"
    else
      render :text => errors_to_json(user.errors), :status => 500, :content_type => "text/x-json"
    end
  end
  
  private
  
  def errors_to_json(errors)
    sanitized = {}
    errors.each do |attribute, message|
      sanitized[attribute] ||= []
      sanitized[attribute] << message
    end
    sanitized.to_json
  end
  
end
