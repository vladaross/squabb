# frozen_string_literal: true

class Reply < ApplicationRecord
  belongs_to :argument
  belongs_to :user
  has_many :votes, as: :item

  validates :content, presence: true
end
