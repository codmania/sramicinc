require 'test_helper'

class JobHistoriesControllerTest < ActionController::TestCase
  setup do
    @job_history = job_histories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:job_histories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create job_history" do
    assert_difference('JobHistory.count') do
      post :create, job_history: {  }
    end

    assert_redirected_to job_history_path(assigns(:job_history))
  end

  test "should show job_history" do
    get :show, id: @job_history
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @job_history
    assert_response :success
  end

  test "should update job_history" do
    patch :update, id: @job_history, job_history: {  }
    assert_redirected_to job_history_path(assigns(:job_history))
  end

  test "should destroy job_history" do
    assert_difference('JobHistory.count', -1) do
      delete :destroy, id: @job_history
    end

    assert_redirected_to job_histories_path
  end
end
