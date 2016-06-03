class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    @url = 'http://azure.paulz.site:3000'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def test_my_mailer(user)
    @user = user
    print('test ok')
    print(@user)
  end

  def notify_email(order)
    @order = order
    @user = @order.user
    mail(to: @user.email, subject: '通知')
  end
end