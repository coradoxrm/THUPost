class ProductsController < ApplicationController
  # status 0 open 1 close 2 dicussion 3 selled
  before_action :authenticate_user!
  def show
    @order = Order.new
    @product = Product.find params[:id]
    @iscollection = 0
    for i in current_user.collections
      # puts "nimas"
      # puts i.product_id
      # puts params[:id] 
      if i.product_id == params[:id].to_i
        @iscollection = 1
      end
    end
  end

  def new
    @product = Product.new
    #puts "2312312"
  end

  def create
    #skip_before_action :verify_authenticity_token
    puts "debug ++++++++++++++++++++++++++ \n"
    puts params
    #print(params[:pic])

    #print(params[:title])

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

  def default_value(l, d)
    if params.has_key? :l
      return params[l]
    else
      return d
    end
  end

  def search
    #limitl = params["limitl"]
    #limitr = params["limitr"]
    limitl = default_value("l", 0)
    limitr = default_value("r", 30)
    search_content = params["query"]
    @products = Product.find_by_sql("select * from products where
      (tag like '%#{search_content}%' or
      title like '%#{search_content}%' or
      description like '%#{search_content}%) and status = 0'
      order by id limit #{limitl}, #{limitr}")
  end

  

  def tag
    @tag_name = params["tag"]
    l = default_value("l", 0);
    r = default_value("r", 20);
    @products = Product.find_by_sql("select * from products where tag like '%#{@tag_name}%' and status = 0 order by id limit #{l}, #{r}")
  end

  def change_status_byorder(order, new_status)
    product = order.product
    product.status = new_status
    product.save
  end

end
