# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    name 'Event name'
    start_time Date.today.beginning_of_month
    user
    text 'Event text'
    recurrent 'none'
  end

  trait :another_user_event do
    user :another_user
  end

  trait :daily do
    recurrent 'daily'
  end

  trait :weekly do
    recurrent 'weekly'
  end

  trait :monthly do
    recurrent 'monthly'
  end

  trait :annually do
    recurrent 'annually'
  end
end
