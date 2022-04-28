require "test_helper"

class AddressesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get addresses_index_url
    assert_response :success
  end

  test "should get edit" do
    get addresses_edit_url
    assert_response :success
  end
end
