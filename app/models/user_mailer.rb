class UserMailer < ActionMailer::Base
  def signup_notification(user)
    setup_email(user)
    @subject = "New Adhearsion Sandbox Account"
  
    @body[:url]  = "http://adhearsion.com/activate/#{user.activation_code}"
  
  end
  
  def activation(user)
    setup_email(user)
    @subject    += 'Your account has been activated!'
    @body[:url]  = "http://adhearsion.com/"
  end
  
  protected
    def setup_email(user)
      @recipients  = "#{user.email}"
      @from        = "noreply@adhearsion.com"
      @sent_on     = Time.now
      @body[:user] = user
    end
end
