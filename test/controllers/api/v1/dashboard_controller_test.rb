require 'test_helper'

class Api::V1::DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get contact_info" do
    get api_v1_dashboard_contact_info_url
    assert_response :success
  end

  test "should get home" do
    get api_v1_dashboard_home_url
    assert_response :success
  end

  test "should get terms_of_aggrement" do
    get api_v1_dashboard_terms_of_aggrement_url
    assert_response :success
  end

end
