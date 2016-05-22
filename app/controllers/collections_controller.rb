class CollectionsController < ApplicationController
  before_action :authenticate_user!
  def show
    collections = current_user.collections
    @products = []
    for i in collections
      @products.push(Product.where(:product => i.product))
    end
  end

  def new
    @product = Product.find(params[:id])
    @order = current_user.collections.build()
    @order.save
  end

  def remove
    product = Product.find(params[:id])
    order = Collections.where(:user => current_user, :product => product)
    order.destroy
  end
  
end
