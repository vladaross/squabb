# frozen_string_literal: true

class DiscussionsMember < ApplicationRecord
  belongs_to :discussion
  belongs_to :user
  has_many :discussions
  has_many :users

  ALLOWED_SIDES = %w[right left].freeze

  validates :side, inclusion: { in: ALLOWED_SIDES }
end
