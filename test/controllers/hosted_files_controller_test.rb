require 'test_helper'

class HostedFilesControllerTest < ActionController::TestCase
  setup do
    @hosted_file = hosted_files(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hosted_files)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hosted_file" do
    assert_difference('HostedFile.count') do
      post :create, hosted_file: { file_name: @hosted_file.file_name, friendly_name: @hosted_file.friendly_name, node_id: @hosted_file.node_id, organization_id: @hosted_file.organization_id, s3_url: @hosted_file.s3_url }
    end

    assert_redirected_to hosted_file_path(assigns(:hosted_file))
  end

  test "should show hosted_file" do
    get :show, id: @hosted_file
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @hosted_file
    assert_response :success
  end

  test "should update hosted_file" do
    patch :update, id: @hosted_file, hosted_file: { file_name: @hosted_file.file_name, friendly_name: @hosted_file.friendly_name, node_id: @hosted_file.node_id, organization_id: @hosted_file.organization_id, s3_url: @hosted_file.s3_url }
    assert_redirected_to hosted_file_path(assigns(:hosted_file))
  end

  test "should destroy hosted_file" do
    assert_difference('HostedFile.count', -1) do
      delete :destroy, id: @hosted_file
    end

    assert_redirected_to hosted_files_path
  end
end
