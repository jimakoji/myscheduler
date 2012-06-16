require 'test_helper'

class AccountControllerTest < ActionController::TestCase
  test "should get new_group" do
    get :new_group
    assert_response :success
  end

end
