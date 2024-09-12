# frozen_string_literal: true

class Vacancy < ApplicationRecord
  include AASM

  validates :title, presence: true
  validates :description, presence: true

  # BEGIN
  aasm column: :aasm_state do
    state :on_moderate, initial: true
    state :published
    state :archived

    event :publish do
      transitions from: :on_moderate, to: :published
    end

    event :archive do
      transitions from: [:on_moderate, :published], to: :archived
    end
  end

  scope :on_moderate, -> { where(aasm_state: 'on_moderate') }
  scope :published, -> { where(aasm_state: 'published') }
  scope :archived, -> { where(aasm_state: 'archived') }
  # END
end
