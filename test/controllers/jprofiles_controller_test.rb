require 'test_helper'

class JprofilesControllerTest < ActionController::TestCase
  setup do
    @jprofile = jprofiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:jprofiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create jprofile" do
    assert_difference('Jprofile.count') do
      post :create, jprofile: {  }
    end

    assert_redirected_to jprofiles_path(assigns(:jprofile))
  end

  test "should show jprofile" do
    get :show, id: @jprofile
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @jprofile
    assert_response :success
  end

  test "should update jprofile" do
    patch :update, id: @jprofile, jprofile: {  }
    assert_redirected_to jprofiles_path(assigns(:jprofile))
  end

  test "should destroy jprofile" do
    assert_difference('Jprofile.count', -1) do
      delete :destroy, id: @jprofile
    end

    assert_redirected_to jprofiles_path
  end
end
