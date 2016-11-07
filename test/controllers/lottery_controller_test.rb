require 'test_helper'

class LotteryControllerTest < ActionController::TestCase
  test "should get wheel" do
    get :wheel
    assert_response :success
  end

end
