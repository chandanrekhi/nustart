require 'test_helper'

class StartupsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:startups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create startup" do
    assert_difference('Startup.count') do
      post :create, :startup => { }
    end

    assert_redirected_to startup_path(assigns(:startup))
  end

  test "should show startup" do
    get :show, :id => startups(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => startups(:one).id
    assert_response :success
  end

  test "should update startup" do
    put :update, :id => startups(:one).id, :startup => { }
    assert_redirected_to startup_path(assigns(:startup))
  end

  test "should destroy startup" do
    assert_difference('Startup.count', -1) do
      delete :destroy, :id => startups(:one).id
    end

    assert_redirected_to startups_path
  end
end
