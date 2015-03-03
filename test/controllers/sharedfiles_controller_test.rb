require 'test_helper'

class SharedfilesControllerTest < ActionController::TestCase
  setup do
    @sharedfile = sharedfiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sharedfiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sharedfile" do
    assert_difference('Sharedfile.count') do
      post :create, sharedfile: { category: @sharedfile.category, description: @sharedfile.description, filepath: @sharedfile.filepath, name: @sharedfile.name, uploader: @sharedfile.uploader }
    end

    assert_redirected_to sharedfile_path(assigns(:sharedfile))
  end

  test "should show sharedfile" do
    get :show, id: @sharedfile
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sharedfile
    assert_response :success
  end

  test "should update sharedfile" do
    patch :update, id: @sharedfile, sharedfile: { category: @sharedfile.category, description: @sharedfile.description, filepath: @sharedfile.filepath, name: @sharedfile.name, uploader: @sharedfile.uploader }
    assert_redirected_to sharedfile_path(assigns(:sharedfile))
  end

  test "should destroy sharedfile" do
    assert_difference('Sharedfile.count', -1) do
      delete :destroy, id: @sharedfile
    end

    assert_redirected_to sharedfiles_path
  end
end
