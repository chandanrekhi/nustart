class UserMailer < ActionMailer::Base
  def signup_notification(user)
    setup(user)
    @subject    += 'Please activate your new account'
    @body[:url]  = "http://#{HOST}/activate/#{user.activation_code}"
  end
  
  def activation(user)
    setup(user)
    @subject    += 'Your account has been activated!'
    @body[:url]  = "http://#{HOST}/"
  end
  
  def forgot_password(user)
    setup(user)
    @subject    += 'You have requested to change your password'
    @body[:url]  = "http://#{HOST}/reset_password/#{user.password_reset_code}"
  end

  def reset_password(user)
    setup(user)
    @subject    += 'Your password has been reset.'
  end
  
  protected
  
  def setup(user)
    @recipients  = "#{user.email}"
    @from        = "administrator@workforastartup.com"
    @subject     = "[WFAS] "
    @sent_on     = Time.now
    @body[:user] = user
  end
end
