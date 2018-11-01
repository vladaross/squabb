# frozen_string_literal: true

FactoryBot.define do
  factory :discussion do
    left_side 'sgdq'
    right_side 'agdq'
    user_id 1
    category_id 1
  end
end
