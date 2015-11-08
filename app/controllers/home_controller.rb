class HomeController < ApplicationController
  before_action :authenticate_user! #check login state if not goto login_page
  def index
    @products = Product.order(id: :desc).limit(40)
  end

  def minor
  end
end
