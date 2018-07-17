# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :user
  validates :name, :start_time, :text, presence: true
end
