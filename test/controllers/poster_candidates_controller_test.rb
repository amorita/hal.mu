require 'test_helper'

class PosterCandidatesControllerTest < ActionController::TestCase
  setup do
    @poster_candidate = poster_candidates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:poster_candidates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create poster_candidate" do
    assert_difference('PosterCandidate.count') do
      post :create, poster_candidate: { mail: @poster_candidate.mail, selection: @poster_candidate.selection, user_id: @poster_candidate.user_id }
    end

    assert_redirected_to poster_candidate_path(assigns(:poster_candidate))
  end

  test "should show poster_candidate" do
    get :show, id: @poster_candidate
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @poster_candidate
    assert_response :success
  end

  test "should update poster_candidate" do
    patch :update, id: @poster_candidate, poster_candidate: { mail: @poster_candidate.mail, selection: @poster_candidate.selection, user_id: @poster_candidate.user_id }
    assert_redirected_to poster_candidate_path(assigns(:poster_candidate))
  end

  test "should destroy poster_candidate" do
    assert_difference('PosterCandidate.count', -1) do
      delete :destroy, id: @poster_candidate
    end

    assert_redirected_to poster_candidates_path
  end
end
