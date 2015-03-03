require 'test_helper'

class EnqAnswersControllerTest < ActionController::TestCase
  setup do
    @enq_answer = enq_answers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:enq_answers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create enq_answer" do
    assert_difference('EnqAnswer.count') do
      post :create, enq_answer: { age: @enq_answer.age, district: @enq_answer.district, gender: @enq_answer.gender, source: @enq_answer.source, time_req: @enq_answer.time_req }
    end

    assert_redirected_to enq_answer_path(assigns(:enq_answer))
  end

  test "should show enq_answer" do
    get :show, id: @enq_answer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @enq_answer
    assert_response :success
  end

  test "should update enq_answer" do
    patch :update, id: @enq_answer, enq_answer: { age: @enq_answer.age, district: @enq_answer.district, gender: @enq_answer.gender, source: @enq_answer.source, time_req: @enq_answer.time_req }
    assert_redirected_to enq_answer_path(assigns(:enq_answer))
  end

  test "should destroy enq_answer" do
    assert_difference('EnqAnswer.count', -1) do
      delete :destroy, id: @enq_answer
    end

    assert_redirected_to enq_answers_path
  end
end
