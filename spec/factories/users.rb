# frozen_string_literal: true

FactoryBot.define do
  sequence :email do |n|
    "email#{n}@factory.com"
  end

  sequence :username do |n|
    "Name#{n}"
  end

  factory :user do
    email
    username
    password 'password'
    password_confirmation 'password'
  end

  trait :another_user do
    email
    username
  end
end
