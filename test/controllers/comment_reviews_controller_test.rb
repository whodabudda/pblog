require 'test_helper'

class CommentReviewsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get comment_reviews_new_url
    assert_response :success
  end

  test "should get create" do
    get comment_reviews_create_url
    assert_response :success
  end

  test "should get index" do
    get comment_reviews_index_url
    assert_response :success
  end

  test "should get show" do
    get comment_reviews_show_url
    assert_response :success
  end

end
