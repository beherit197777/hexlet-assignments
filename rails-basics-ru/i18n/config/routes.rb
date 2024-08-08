# frozen_string_literal: true

Rails.application.routes.draw do
  # BEGIN
  Rails.application.routes.draw do
    scope "(:locale)", locale: /en|ru/ do
      root 'home#index'
      resources :posts
    end
  end
  

  # END

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
