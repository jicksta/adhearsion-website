class UsersController < ApplicationController
  
  # Protect these actions behind an admin login
  # before_filter :admin_required, :only => [:suspend, :unsuspend, :destroy, :purge]
  before_filter :find_user, :only => [:suspend, :unsuspend, :destroy, :purge]
  
  before_filter :login_required, :only => "account"
  
  layout "page"
  
  # render new.rhtml
  def new
    @user = User.new
    @title = "Create your account"
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    @user.register! if @user && @user.valid?
    success = @user && @user.valid?
    
    if request.xhr?
      if success && @user.errors.empty?
        render :text => @user.to_json, :content_type => "text/x-json"
      else
        render :text => errors_to_json(@user.errors), :status => 500, :content_type => "text/x-json"
      end
    else
      if success && @user.errors.empty?
        redirect_back_or_default('/')
        flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
      else
        flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin."
        render :action => 'new'
      end
    end
  end

  def account
    @title = "Account Settings"
  end

  def activate
    logout_keeping_session!
    user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && user && !user.active?
      user.activate!
      flash[:notice] = "Signup complete! Please sign in to continue."
      redirect_to '/login'
    when params[:activation_code].blank?
      flash[:error] = "The activation code was missing.  Please follow the URL from your email."
      redirect_back_or_default('/')
    else 
      flash[:error]  = "We couldn't find a user with that activation code. Did you already activate?"
      redirect_back_or_default('/')
    end
  end

  def suspend
    @user.suspend! 
    redirect_to users_path
  end

  def unsuspend
    @user.unsuspend! 
    redirect_to users_path
  end

  def destroy
    @user.delete!
    redirect_to users_path
  end

  def purge
    @user.destroy
    redirect_to users_path
  end
  
  def update
    new_data = params[:user].slice :skype, :email
    
    if current_user.update_attributes(new_data)
      flash[:notice] = "Account information updated!"
    else
      flash[:error] = current_user.errors.full_messages.join("<br/>")
    end
    redirect_to :action => "account"
  end
  
  def change_password
    password, confirmation = params[:user].values_at :password, :password_confirmation
    if password == confirmation
      current_user.password = current_user.password_confirmation = password
      current_user.save
      flash[:notice] = "Password changed successfully"
    else
      flash[:error] = "Passwords do not match!"
    end
    redirect_to :action => "account"
  end
  
  # There's no page here to update or destroy a user.  If you add those, be
  # smart -- make sure you check that the visitor is authorized to do so, that they
  # supply their old password along with a new one to update it, etc.

protected
  def find_user
    @user = User.find(params[:id])
  end
  
  def errors_to_json(errors)
    sanitized = {}
    errors.each do |attribute, message|
      sanitized[attribute] ||= []
      sanitized[attribute] << message
    end
    sanitized.to_json
  end
  
end
