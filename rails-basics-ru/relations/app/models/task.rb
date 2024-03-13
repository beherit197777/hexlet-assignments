# app/models/task.rb

class Task < ApplicationRecord
  belongs_to :user
  belongs_to :status

  validates :name, presence: true

  # Другие атрибуты и методы модели Task
end
