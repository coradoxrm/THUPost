class ProductsController < ApplicationController
  # status 0 dicussion 1 close 2 selled 3
  before_action :authenticate_user!
  def show
    @order = Order.new
    @product = Product.find params[:id]
    @orders = @product.orders.order(price: :desc)
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
      p1 = p0
    end

    if params[:product][:photo2]
      p2 = params[:product][:photo2]
    else
      p2 = p0
    end

    if params[:product][:photo3]
      p3 = params[:product][:photo3]
    else
      p3 = p0
    end

    if params[:product][:photo4]
      p4 = params[:product][:photo4]
    else
      p4 = p0
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
    puts current_user.id
    @products = Product.where(:user_id => current_user.id).order("updated_at DESC").all;
  end

  def default_value(l, d) #not work
    if params.has_key?(:l)
      puts "has key +++++++++++++++++++++"
      return params[l]
    else
      puts "no key +++++++++++++++++++++"
      return d
    end
  end

  def search
    page_limit = 30
    puts params
    @page = Integer(params.has_key?("page") ? params["page"] : 1)
    limitl = (@page-1)*page_limit
    limitr = page_limit
    puts limitl
    puts limitr
    @search_content = params["query"]
    @products = Product.find_by_sql("select * from products where
      (tag like '%#{@search_content}%' or
      title like '%#{@search_content}%' or
      description like '%#{@search_content}%' and status = 0)
      order by id limit #{limitl}, #{limitr}")
    @product_number = Product.find_by_sql("select id from products where
      (tag like '%#{@search_content}%' or
      title like '%#{@search_content}%' or
      description like '%#{@search_content}%' and status = 0)").count
    # puts "product number:" +  String(product_number)
    # puts "product number:" +  String(product_number / page_limit)
    @lastpage = (Float(@product_number) / page_limit).ceil
  end



  def tag

    page_limit = 30
    puts params
    @page = Integer(params.has_key?("page") ? params["page"] : 1)
    limitl = (@page-1)*page_limit
    limitr = page_limit
    puts limitl
    puts limitr
    @search_content = params["query"]
    @products = Product.find_by_sql("select * from products where
      (tag like '%#{@search_content}%' and status = 0)
      order by id desc limit #{limitl}, #{limitr}")
    @product_number = Product.find_by_sql("select id from products where
      (tag like '%#{@search_content}%' and status = 0)").count
    
    @lastpage = (Float(@product_number) / page_limit).ceil

  end

  def change_status_byorder(order, new_status)
    product = order.product
    product.status = new_status
    product.save
  end

  def remove
    product = Product.find(params[:id])
    # for i in product.orders
      # i.destroy
    # end
    product.destroy
    # product.status = 3
    # product.save
    @object = {"status":"success"}
    render :json => @object
  end

  def selled
    product = Product.find(params[:id])
    # for i in product.orders
      # i.destroy
    # end
    # product.destroy
    product.status = 2
    for i in product.orders
      if i.status == 1
        i.status = 2
        i.save
      end
    end
    product.save
    @object = {"status":"success"}
    render :json => @object
  end

  def cancel
    product = Product.find(params[:id])
    product.status = 0
    for i in product.orders
      if i.status == 1
        i.status = 0
        i.save
      end
    end
    product.save
    @object = {"status":"success"}
    render :json => @object
  end
end
