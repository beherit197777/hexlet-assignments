# test/controllers/posts/comments_controller_test.rb
require "test_helper"

class Posts::CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    @comment = post_comments(:one)
  end

  test "should create comment" do
    assert_difference('PostComment.count') do
      post post_comments_path(@post), params: { post_comment: { content: 'Новый комментарий' } }
    end

    assert_redirected_to post_path(@post)
  end

  test "should update comment" do
    patch post_comment_path(@post, @comment), params: { post_comment: { content: 'Обновленный комментарий' } }
    assert_redirected_to post_path(@post)
    @comment.reload
    assert_equal 'Обновленный комментарий', @comment.content
  end

  test "should destroy comment" do
    assert_difference('PostComment.count', -1) do
      delete post_comment_path(@post, @comment)
    end

    assert_redirected_to post_path(@post)
  end
end
