require 'test_helper'

class DistrosControllerTest < ActionController::TestCase
  setup do
    @distro = distros(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:distros)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create distro" do
    assert_difference('Distro.count') do
      post :create, distro: {  }
    end

    assert_redirected_to distro_path(assigns(:distro))
  end

  test "should show distro" do
    get :show, id: @distro
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @distro
    assert_response :success
  end

  test "should update distro" do
    put :update, id: @distro, distro: {  }
    assert_redirected_to distro_path(assigns(:distro))
  end

  test "should destroy distro" do
    assert_difference('Distro.count', -1) do
      delete :destroy, id: @distro
    end

    assert_redirected_to distros_path
  end
end
