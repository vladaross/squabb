# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    login 'that guy'
    email 'that@guy.com'
    password 'mypass'
  end
end
