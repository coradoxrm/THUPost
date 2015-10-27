class OrdersController < ApplicationController
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
  
end
