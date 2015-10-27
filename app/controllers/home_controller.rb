class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @products = Product.order(id: :desc).limit(40)
  end

  def minor
  end
end
