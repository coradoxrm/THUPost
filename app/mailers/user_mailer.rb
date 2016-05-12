class UserMailer < ApplicationMailer
  default from: 'thupost@163.com'

  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    print('before send email')
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
    print('after send email')
  end

  def test_my_mailer(user)
    @user = user
    print('test ok')
    print(@user)
  end
end
