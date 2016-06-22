class UserMailer < ApplicationMailer
  default :from => 'thupost@azure.paulz.site'

  def notify_email(order)
    @order = order
    @user = @order.user
    mail(to: @user.email, subject: '【THUPost】卖家联系方式')
  end

  def receive_email(order)
    @order = order
    @user = @order.product.user
    mail(to: @user.email, subject: '【THUPost】买家联系方式')

end
