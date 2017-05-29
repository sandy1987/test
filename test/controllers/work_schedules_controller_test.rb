require 'test_helper'

class WorkSchedulesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @work_schedule = work_schedules(:one)
  end

  test "should get index" do
    get work_schedules_url
    assert_response :success
  end

  test "should get new" do
    get new_work_schedule_url
    assert_response :success
  end

  test "should create work_schedule" do
    assert_difference('WorkSchedule.count') do
      post work_schedules_url, params: { work_schedule: { amount: @work_schedule.amount, date: @work_schedule.date, location: @work_schedule.location, role: @work_schedule.role, shift_type: @work_schedule.shift_type, time_slot_1: @work_schedule.time_slot_1, time_slot_2: @work_schedule.time_slot_2, total_hours: @work_schedule.total_hours, user_id: @work_schedule.user_id } }
    end

    assert_redirected_to work_schedule_url(WorkSchedule.last)
  end

  test "should show work_schedule" do
    get work_schedule_url(@work_schedule)
    assert_response :success
  end

  test "should get edit" do
    get edit_work_schedule_url(@work_schedule)
    assert_response :success
  end

  test "should update work_schedule" do
    patch work_schedule_url(@work_schedule), params: { work_schedule: { amount: @work_schedule.amount, date: @work_schedule.date, location: @work_schedule.location, role: @work_schedule.role, shift_type: @work_schedule.shift_type, time_slot_1: @work_schedule.time_slot_1, time_slot_2: @work_schedule.time_slot_2, total_hours: @work_schedule.total_hours, user_id: @work_schedule.user_id } }
    assert_redirected_to work_schedule_url(@work_schedule)
  end

  test "should destroy work_schedule" do
    assert_difference('WorkSchedule.count', -1) do
      delete work_schedule_url(@work_schedule)
    end

    assert_redirected_to work_schedules_url
  end
end
