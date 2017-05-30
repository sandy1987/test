require 'test_helper'

class Api::V1::WorkSchedulesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get api_v1_work_schedules_create_url
    assert_response :success
  end

  test "should get destroy" do
    get api_v1_work_schedules_destroy_url
    assert_response :success
  end

  test "should get edit" do
    get api_v1_work_schedules_edit_url
    assert_response :success
  end

  test "should get index" do
    get api_v1_work_schedules_index_url
    assert_response :success
  end

  test "should get my_schedule" do
    get api_v1_work_schedules_my_schedule_url
    assert_response :success
  end

  test "should get new" do
    get api_v1_work_schedules_new_url
    assert_response :success
  end

  test "should get next_schedule" do
    get api_v1_work_schedules_next_schedule_url
    assert_response :success
  end

  test "should get show" do
    get api_v1_work_schedules_show_url
    assert_response :success
  end

  test "should get update" do
    get api_v1_work_schedules_update_url
    assert_response :success
  end

end
