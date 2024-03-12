# frozen_string_literal: true

Rails.application.routes.draw do
  resources :tasks
  root 'home#index'
  get '/tasks', to: 'tasks#index'

  # get 'tasks/:id', to: 'tasks#show', as: 'task_show'

  # BEGIN

  # END
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
