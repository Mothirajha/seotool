require 'test_helper'

class SearchEnginesControllerTest < ActionController::TestCase
  setup do
    @search_engine = search_engines(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:search_engines)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create search_engine" do
    assert_difference('SearchEngine.count') do
      post :create, search_engine: { engine: @search_engine.engine }
    end

    assert_redirected_to search_engine_path(assigns(:search_engine))
  end

  test "should show search_engine" do
    get :show, id: @search_engine
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @search_engine
    assert_response :success
  end

  test "should update search_engine" do
    patch :update, id: @search_engine, search_engine: { engine: @search_engine.engine }
    assert_redirected_to search_engine_path(assigns(:search_engine))
  end

  test "should destroy search_engine" do
    assert_difference('SearchEngine.count', -1) do
      delete :destroy, id: @search_engine
    end

    assert_redirected_to search_engines_path
  end
end
