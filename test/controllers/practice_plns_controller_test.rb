require 'test_helper'

class PracticePlnsControllerTest < ActionController::TestCase
  setup do
    @practice_pln = practice_plns(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:practice_plns)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create practice_pln" do
    assert_difference('PracticePln.count') do
      post :create, practice_pln: {  }
    end

    assert_redirected_to practice_pln_path(assigns(:practice_pln))
  end

  test "should show practice_pln" do
    get :show, id: @practice_pln
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @practice_pln
    assert_response :success
  end

  test "should update practice_pln" do
    patch :update, id: @practice_pln, practice_pln: {  }
    assert_redirected_to practice_pln_path(assigns(:practice_pln))
  end

  test "should destroy practice_pln" do
    assert_difference('PracticePln.count', -1) do
      delete :destroy, id: @practice_pln
    end

    assert_redirected_to practice_plns_path
  end
end
