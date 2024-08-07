class Posts::CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, only: [:edit, :update, :destroy]

  def create
    @comment = @post.post_comments.new(comment_params)
    if @comment.save
      redirect_to @post, notice: 'Комментарий был успешно добавлен.'
    else
      redirect_to @post, alert: 'Ошибка при добавлении комментария.'
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to @post, notice: 'Комментарий был успешно обновлен.'
    else
      redirect_to @post, alert: 'Ошибка при обновлении комментария.'
    end
  end

  def destroy
    @comment.destroy
    redirect_to @post, notice: 'Комментарий был успешно удален.'
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.post_comments.find(params[:id])
  end

  def comment_params
    params.require(:post_comment).permit(:content)
  end
end