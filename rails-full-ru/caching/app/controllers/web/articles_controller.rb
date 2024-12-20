# frozen_string_literal: true

class Web::ArticlesController < Web::ApplicationController
  # BEGIN
  caches_action :show, cache_path: -> { request.fullpath }
  # END

  def index
    @articles = Article.all
  end

  # BEGIN
  def show
    @article = Article.find(params[:id])
  end
  # END
end
