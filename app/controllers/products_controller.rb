class ProductsController < ApplicationController
  before_action :authenticate_user!
  def show
    @order = Order.new
    @product = Product.find params[:id]
  end

  def new
    @product = Product.new
    # puts "`2312312"
  end

  def create
    puts "debug"
    puts params
    @product = current_user.products.build(
      title: params[:title],
      price: params[:price],
      description: params[:description],
      tag: params[:tag]
    )
    @product.save
    redirect_to product_path(@product)
  end

  def for_sale
    @products = current_user.products
  end

  def search
    #limitl = params["limitl"]
    #limitr = params["limitr"]
    limitl = 0
    limitr = 30
    search_content = params["query"]
    @products = Product.find_by_sql("select * from products where
      tag like '%#{search_content}%' or
      title like '%#{search_content}%' or
      description like '%#{search_content}%'
      order by id limit #{limitl}, #{limitr}")
  end

  def tag
    @tag_name = params["tag"]
    @products = Product.find_by_sql("select * from products where tag like '%#{@tag_name}%' order by id limit #{0}, #{40}")
  end

end
