# frozen_string_literal: true

module Web
  class Movies::CommentsController < Movies::ApplicationController
    def index
      @comments = resource_movie.comments
    end

    def new
      @comment = resource_movie.comments.build
    end

    def create
      @comment = resource_movie.comments.build(comment_params)

      if @comment.save
        redirect_to movie_comments_path(resource_movie), notice: t('success')
      else
        flash[:notice] = t('fail')
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @comment = Comment.find(params[:id])
    end

    def update
      @comment = Comment.find(params[:id])

      if @comment.update(comment_params)
        redirect_to movie_comments_path(resource_movie), notice: t('.success')
      else
        redirect_to movies_path, notice: t('.fail')
      end
    end

    def destroy
      @comment = Comment.find(params[:id])

      if @comment.destroy
        redirect_to  movie_comments_path(resource_movie), notice: t('.success')
      else
        redirect_to  movie_comments_path(resource_movie), notice: t('.fail')
      end
    end

    private

    def comment_params
      params.require(:comment).permit(:body)
    end
  end
end
