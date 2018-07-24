# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  it { should belong_to(:user) }
  it { should validate_presence_of :name }
  it { should validate_presence_of :start_time }
  it { should validate_presence_of :text }
  it { should validate_inclusion_of(:recurrent).in_array(Event::RECURRENT) }
end
