class Mailer < ActionMailer::Base
  def reset_password( reset_password, reset_password_url )
    recipients  reset_password.user.email
    from        "johan@reserve-gakuwarinet.com"
    subject     "Password Reset"
    body        :reset_password => reset_password, :reset_password_url => reset_password_url
  end      
end
