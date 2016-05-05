class HomeController < ApplicationController
  before_action :authenticate_user! #check login state if not goto login_page

  def get_category(cate, limitl, limitr)
    return Product.find_by_sql("select * from products where tag like '%#{cate}%' order by id limit #{limitl}, #{limitr}")
  end

  def index
    @products = get_category("生活用品", 0, 40)
  end

  

  def minor
  end
end
