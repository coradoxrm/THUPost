class UserMailer < ApplicationMailer
  default :from => 'thupost@thupost.cn'

  def notify_email(order)
    @order = order
    @user = @order.user
    mail(to: @user.email, subject: '【THUPost】卖家联系方式')
  end


  def notify_seller_email(order)
    @order = order
    @seller = @order.product.user
    mail(to: @seller.email, subject: '交易确认通知')
  end

  def notify_order_email(order)
    @order = order
    @seller = @order.product.user
    mail(to: @seller.email, subject: '订单创建通知')
  end
end
