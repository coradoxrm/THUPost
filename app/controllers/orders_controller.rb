class OrdersController < ApplicationController
  include SendText
  before_action :authenticate_user!

  def create
    @product = Product.find(params[:id])
    @product
    @order = current_user.orders.build(
        product: @product,
        price: params[:price],
        description: params[:description]
    )
    @order.save

    # send notify email to seller
    #UserMailer.notify_order_email(@order).deliver_later

    redirect_to product_path(@product)
  end

  def index
    @orders = current_user.orders
  end

  def notify_email
    if Time.now.to_i - current_user.last_email_time < 3600 * 2
      @res = {:code => 1}
      render :json => @res
      return
    end
    @order = Order.find(params[:order_id])
    UserMailer.notify_email(@order).deliver_later
    UserMailer.notify_seller_email(@order).deliver_later
    @order.status = 1
    @order.product.status = 1
    @order.product.save
    @order.save
    current_user.last_email_time = Time.now.to_i
    current_user.save
    @res = {:code => 0}
    render :json => @res
  end

  def notify_text
    if Time.now.to_i - current_user.last_next_time < 3600 * 2
      @res = {:code => 1}
      render :json => @res
      return
    end
    @order = Order.find(params[:order_id])
    send_notify_text @order
    @order.status = 1
    @order.product.status = 1
    @order.product.save
    @order.save
    current_user.last_next_time = Time.now.to_i
    current_user.save
    @res = {:code => 0}
    render :json => @res
  end

  def change_status(order, new_status)
    order.status = new_status
    order.save
  end

  def remove
    order = Order.find(params[:id])
    if order.status == 1
      order.product.status = 0
      order.product.save
    end
    order.destroy
    @object = {"status": "success"}
    render :json => @object
  end
end
