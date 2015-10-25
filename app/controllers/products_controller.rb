class ProductsController < ApplicationController
  before_action :authenticate_user!
  def show
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
    redirect_to products_show_path
  end

  def for_sale
  end

  def order
  end
end
