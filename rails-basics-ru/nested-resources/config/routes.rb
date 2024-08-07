# frozen_string_literal: true

Rails.application.routes.draw do
  root 'homes#index'
  # BEGIN
    resources :posts do
      resources :post_comments, controller: 'posts/comments', only: [:create, :edit, :update, :destroy]
    end
  # END
end
