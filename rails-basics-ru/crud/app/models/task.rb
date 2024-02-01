# frozen_string_literal: true

class Task < ApplicationRecord
  STATUSES = %i[new in_progress completed].freeze
  validates :name, presence: true
  validates :description, presence: true
  validates :creator, presence: true
  validates :performer, presence: true
end
