# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :user
  validates :name, :start_time, :text, presence: true

  delegate :email, to: :user
  delegate :username, to: :user
end
