require 'test_helper'

class Admin::JobsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_jobs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_job" do
    assert_difference('Job.count') do
      post :create, :admin_job => { }
    end

    assert_redirected_to admin_job_path(assigns(:admin_job))
  end

  test "should show admin_job" do
    get :show, :id => admin_jobs(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => admin_jobs(:one).id
    assert_response :success
  end

  test "should update admin_job" do
    put :update, :id => admin_jobs(:one).id, :admin_job => { }
    assert_redirected_to admin_job_path(assigns(:admin_job))
  end

  test "should destroy admin_job" do
    assert_difference('Job.count', -1) do
      delete :destroy, :id => admin_jobs(:one).id
    end

    assert_redirected_to admin_jobs_path
  end
end
