# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :user

  RECURRENT = %w[none daily weekly monthly annually].freeze

  validates :name, :start_time, :text, presence: true
  validates :recurrent, inclusion: { in: Event::RECURRENT }

  delegate :email, to: :user
  delegate :username, to: :user
end
