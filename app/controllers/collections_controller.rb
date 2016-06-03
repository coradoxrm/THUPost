class CollectionsController < ApplicationController
  before_action :authenticate_user!
  def show
    collections = current_user.collections
    @products = []
    for i in collections
      # puts "debugs"
      # puts i.product_id
      # puts i.user_id
      product = Product.where(:id => i.product_id).first()
      @products.push(product)
    end
  end

  def new
    # puts "start new"
    product = Product.find(params[:id])
    # puts current_user.id
    # puts product.id
    if (Collection.where(:user_id => current_user.id, :product_id => product.id).all == [])
      order = Collection.create(:user_id => current_user.id, :product_id => product.id)
      order.save
      @object = {"status":"success"}
      render :json => @object
      return
    end
    @object = {"status":"error", "desc":"repeat object"}
    render :json => @object
    # puts Collection.where(:user_id => current_user.id, :product_id => product.id).all


  end

  def remove
    product = Product.find(params[:id])
    if (Collection.where(:user_id => current_user.id, :product_id => product.id).all != [])
      order = Collection.where(:user_id => current_user.id, :product_id => product.id).first()
      order.destroy
      @object = {"status":"success"}
      render :json => @object
      return;
    end
    @object = {"status":"error", "desc":"no such object"}
    render :json => @object
  end

end
