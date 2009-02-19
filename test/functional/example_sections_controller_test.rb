require 'test_helper'

class ExampleSectionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:example_sections)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create example_section" do
    assert_difference('ExampleSection.count') do
      post :create, :example_section => { }
    end

    assert_redirected_to example_section_path(assigns(:example_section))
  end

  test "should show example_section" do
    get :show, :id => example_sections(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => example_sections(:one).id
    assert_response :success
  end

  test "should update example_section" do
    put :update, :id => example_sections(:one).id, :example_section => { }
    assert_redirected_to example_section_path(assigns(:example_section))
  end

  test "should destroy example_section" do
    assert_difference('ExampleSection.count', -1) do
      delete :destroy, :id => example_sections(:one).id
    end

    assert_redirected_to example_sections_path
  end
end
