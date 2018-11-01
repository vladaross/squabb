# frozen_string_literal: true

class Argument < ApplicationRecord
  belongs_to :user
  belongs_to :discussion
  has_many :replies, dependent: :destroy
  has_many :votes, as: :item

  validates :content, presence: true
end
