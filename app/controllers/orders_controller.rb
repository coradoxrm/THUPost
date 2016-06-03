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
    redirect_to product_path(@product)
  end

  def index
    @orders = current_user.orders
  end

  def notify_email
    @order = Order.find(params[:order_id])
    UserMailer.notify_email(@order)
    @order.status = 1
    @order.product.status = 1
    @order.product.save
    @order.save
    @res = {:code => 0}
    render :json => @res
  end

  def notify_text
    @order = Order.find(params[:order_id])
    @order.status = 1
    @order.product.status = 1
    @order.product.save
    @order.save
    send_notify_text @order
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
