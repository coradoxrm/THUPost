class UserMailer < ApplicationMailer
  default :from => 'thupost@soavm.chinacloudapp.cn'

  def notify_email(order)
    @order = order
    @user = @order.user
    mail(to: @user.email, subject: '【THUPost】卖家联系方式')
  end


  def notify_seller_email(order)
    @order = order
    @seller = @order.product.user
    mail(to: @seller.email, subject: '【THUPost】买家联系方式')
  end

  def notify_order_email(order)
    @order = order
    @seller = @order.product.user
    mail(to: @seller.email, subject: '【THUPost】新的订单通知')
  end
end
