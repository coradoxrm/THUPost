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
    puts params
    if params[:product][:photo0]
      p0 = params[:product][:photo0]
    else
      p0 = nil
    end

    if params[:product][:photo1]
      p1 = params[:product][:photo1]
    else
      p1 = nil
    end

    if params[:product][:photo2]
      p2 = params[:product][:photo2]
    else
      p2 = nil
    end

    if params[:product][:photo3]
      p3 = params[:product][:photo3]
    else
      p3 = nil
    end

    if params[:product][:photo4]
      p4 = params[:product][:photo4]
    else
      p4 = nil
    end
    puts "productdebug"
    puts p0
    puts p1
    puts p2
    puts p3
    puts p4
    
    @product = current_user.products.build(
      title: params[:title],
      price: params[:price],
      description: params[:description],
      tag: params[:tag],
      photo0: p0,
      photo1: p1,
      photo2: p2,
      photo3: p3,
      photo4: p4
    )
    puts @product
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
