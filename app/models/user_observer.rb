class UserObserver < ActiveRecord::Observer
  
  def after_create(user)
    if !user.email != '' and !user.email.nil?
      UserMailer.deliver_signup_notification(user)
    end
  end

  def after_save(user)
    if user.email != '' and !user.email.nil?
      UserMailer.deliver_activation(user) if user.recently_activated?
      UserMailer.deliver_forgot_password(user) if user.recently_forgot_password?
    end
  end
  
end
