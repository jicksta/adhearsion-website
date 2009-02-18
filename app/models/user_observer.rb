class UserObserver < ActiveRecord::Observer
  def after_create(user)
    UserMailer.deliver_signup_notification(user)
  end

  def after_save(user)
    if user.recently_activated?
      # UserMailer.deliver_activation(user)
      
      if user.receive_emails?
        escaped_email = URI.escape user.email
        open("http://groups.google.com/group/adhearsion/boxsubscribe" +    
            "?p=ConfirmExplanation&amp;email=#{escaped_email}&amp;_referer"
        ).read
      end
    end
  end
end
