# frozen_string_literal: true

FactoryBot.define do
  factory :discussions_member do
    user_id 1
    discussion_id 1
    side 'right'
  end
end
