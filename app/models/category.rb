# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :discussions
  resourcify

  validates :title, length: { in: 1..20 }
end
