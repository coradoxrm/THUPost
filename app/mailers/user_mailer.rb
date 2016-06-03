class UserMailer < ApplicationMailer
  def notify_email(order)
    @order = order
    @user = @order.user
    mail(to: @user.email, subject: '卖家确认通知')
  end
end