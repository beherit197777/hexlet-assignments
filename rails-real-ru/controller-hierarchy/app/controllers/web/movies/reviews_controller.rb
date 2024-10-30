# frozen_string_literal: true

module Web
  class Movies::ReviewsController < Movies::ApplicationController
    def index
      @reviews = resource_movie.reviews
    end

    def new
      @review = resource_movie.reviews.build
    end

    def create
      @review = resource_movie.reviews.build(review_params)

      if @review.save
        redirect_to movie_reviews_path(resource_movie), notice: t('success')
      else
        flash[:notice] = t('fail')
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @review = Review.find(params[:id])
    end

    def update
      @review = Review.find(params[:id])

      if @review.update(review_params)
        redirect_to movie_reviews_path(resource_movie), notice: t('.success')
      else
        redirect_to movies_path, notice: t('.fail')
      end
    end

    def destroy
      @review = Review.find(params[:id])

      if @review.destroy
        redirect_to  movie_reviews_path(resource_movie), notice: t('.success')
      else
        redirect_to  movie_reviews_path(resource_movie), notice: t('.fail')
      end
    end

    private

    def review_params
      params.require(:review).permit(:body)
    end
  end
end
