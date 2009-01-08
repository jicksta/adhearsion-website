class SandboxMailer < ActionMailer::Base
  def signup_notification(sandbox_user)
    recipients sandbox_user.email
    from "noreply@adhearsion.com"
    subject "New Adhearsion Sandbox Account"
    body :name => sandbox_user.name, :username => sandbox_user.username
  end
end
