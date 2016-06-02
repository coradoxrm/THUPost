class HomeController < ApplicationController
  before_action :authenticate_user! #check login state if not goto login_page

  def get_category(cate, limitl, limitr)
    return Product.find_by_sql("select * from products where tag like '%#{cate}%' order by id limit #{limitl}, #{limitr}")
  end

  def index
    @products = Product.find_by_sql("select * from products order by id limit #{0}, #{20}")

    my_products = current_user.products
    @order_count = 0
    @likes_count = 0
    for p in my_products
      if (p.status != 2)
        @order_count += p.orders.length
      end
      @likes_count += p.collections.length
    end

    my_orders = current_user.orders
    @notif_count = 0
    for o in my_orders
      if(o.status == 1)
        @notif_count += 1
      end
    end





  end

  def minor
  end
end
