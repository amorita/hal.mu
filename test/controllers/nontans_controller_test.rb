require 'test_helper'

class NontansControllerTest < ActionController::TestCase
  setup do
    @nontan = nontans(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:nontans)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create nontan" do
    assert_difference('Nontan.count') do
      post :create, nontan: { part_id: @nontan.part_id, practice_pln_id: @nontan.practice_pln_id, reason: @nontan.reason, subs_name: @nontan.subs_name, user_name: @nontan.user_name }
    end

    assert_redirected_to nontan_path(assigns(:nontan))
  end

  test "should show nontan" do
    get :show, id: @nontan
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @nontan
    assert_response :success
  end

  test "should update nontan" do
    patch :update, id: @nontan, nontan: { part_id: @nontan.part_id, practice_pln_id: @nontan.practice_pln_id, reason: @nontan.reason, subs_name: @nontan.subs_name, user_name: @nontan.user_name }
    assert_redirected_to nontan_path(assigns(:nontan))
  end

  test "should destroy nontan" do
    assert_difference('Nontan.count', -1) do
      delete :destroy, id: @nontan
    end

    assert_redirected_to nontans_path
  end
end
