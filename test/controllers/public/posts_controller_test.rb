require "test_helper"

class Public::PostsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_posts_index_url
    assert_response :success
  end

  test "should get new" do
    get public_posts_new_url
    assert_response :success
  end

  test "should get search" do
    get public_posts_search_url
    assert_response :success
  end
end
