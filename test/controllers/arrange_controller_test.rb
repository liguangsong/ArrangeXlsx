require 'test_helper'

class ArrangeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
