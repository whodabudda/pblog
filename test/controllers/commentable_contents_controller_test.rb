require 'test_helper'

class CommentableContentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @commentable_content = commentable_contents(:one)
  end

  test "should get index" do
    get commentable_contents_url
    assert_response :success
  end

  test "should get new" do
    get new_commentable_content_url
    assert_response :success
  end

  test "should create commentable_content" do
    assert_difference('CommentableContent.count') do
      post commentable_contents_url, params: { commentable_content: {  } }
    end

    assert_redirected_to commentable_content_url(CommentableContent.last)
  end

  test "should show commentable_content" do
    get commentable_content_url(@commentable_content)
    assert_response :success
  end

  test "should get edit" do
    get edit_commentable_content_url(@commentable_content)
    assert_response :success
  end

  test "should update commentable_content" do
    patch commentable_content_url(@commentable_content), params: { commentable_content: {  } }
    assert_redirected_to commentable_content_url(@commentable_content)
  end

  test "should destroy commentable_content" do
    assert_difference('CommentableContent.count', -1) do
      delete commentable_content_url(@commentable_content)
    end

    assert_redirected_to commentable_contents_url
  end
end
