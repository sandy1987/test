require 'test_helper'

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @profile = profiles(:one)
  end

  test "should get index" do
    get profiles_url
    assert_response :success
  end

  test "should get new" do
    get new_profile_url
    assert_response :success
  end

  test "should create profile" do
    assert_difference('Profile.count') do
      post profiles_url, params: { profile: { answer: @profile.answer, company: @profile.company, home_address: @profile.home_address, image: @profile.image, name: @profile.name, phone: @profile.phone, position: @profile.position, security: @profile.security, security_question: @profile.security_question } }
    end

    assert_redirected_to profile_url(Profile.last)
  end

  test "should show profile" do
    get profile_url(@profile)
    assert_response :success
  end

  test "should get edit" do
    get edit_profile_url(@profile)
    assert_response :success
  end

  test "should update profile" do
    patch profile_url(@profile), params: { profile: { answer: @profile.answer, company: @profile.company, home_address: @profile.home_address, image: @profile.image, name: @profile.name, phone: @profile.phone, position: @profile.position, security: @profile.security, security_question: @profile.security_question } }
    assert_redirected_to profile_url(@profile)
  end

  test "should destroy profile" do
    assert_difference('Profile.count', -1) do
      delete profile_url(@profile)
    end

    assert_redirected_to profiles_url
  end
end
