require 'test_helper'

class KashflowsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @kashflow = kashflows(:one)
  end

  test "should get index" do
    get kashflows_url
    assert_response :success
  end

  test "should get new" do
    get new_kashflow_url
    assert_response :success
  end

  test "should create kashflow" do
    assert_difference('Kashflow.count') do
      post kashflows_url, params: { kashflow: { year: @kashflow.year } }
    end

    assert_redirected_to kashflow_url(Kashflow.last)
  end

  test "should show kashflow" do
    get kashflow_url(@kashflow)
    assert_response :success
  end

  test "should get edit" do
    get edit_kashflow_url(@kashflow)
    assert_response :success
  end

  test "should update kashflow" do
    patch kashflow_url(@kashflow), params: { kashflow: { year: @kashflow.year } }
    assert_redirected_to kashflow_url(@kashflow)
  end

  test "should destroy kashflow" do
    assert_difference('Kashflow.count', -1) do
      delete kashflow_url(@kashflow)
    end

    assert_redirected_to kashflows_url
  end
end
