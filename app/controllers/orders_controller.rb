class OrdersController < ApplicationController
  # NOTE: fix CSRF in future
  skip_before_filter :verify_authenticity_token

  def create
    @product = Product.find(params[:id])
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
    UserMailer.notify_email(@order).deliver_now
    @res = {:code => 0}
    render :json => @res
  end

  def notify_text
    @res = {:code => 0}
    render :json => @res
  end

  def change_status(order, new_status)
    order.status = new_status
    order.save
  end

end
