class ProductsController < ApplicationController
  before_action :authenticate_user!
  def show
    @order = Order.new
    @product = Product.find params[:id]
  end

  def new
    @product = Product.new
  end

  def create
    @product = current_user.products.build(
      title: params[:title],
      price: params[:price],
      description: params[:description]
    )
    @product.save
    redirect_to product_path(@product)
  end

  def for_sale
    @products = current_user.products
  end

  def order
  end
end
