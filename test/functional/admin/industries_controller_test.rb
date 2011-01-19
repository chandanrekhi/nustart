require 'test_helper'

class Admin::IndustriesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_industries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_industry" do
    assert_difference('Industry.count') do
      post :create, :admin_industry => { }
    end

    assert_redirected_to admin_industry_path(assigns(:admin_industry))
  end

  test "should show admin_industry" do
    get :show, :id => admin_industries(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => admin_industries(:one).id
    assert_response :success
  end

  test "should update admin_industry" do
    put :update, :id => admin_industries(:one).id, :admin_industry => { }
    assert_redirected_to admin_industry_path(assigns(:admin_industry))
  end

  test "should destroy admin_industry" do
    assert_difference('Industry.count', -1) do
      delete :destroy, :id => admin_industries(:one).id
    end

    assert_redirected_to admin_industries_path
  end
end
