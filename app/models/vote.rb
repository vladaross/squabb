# frozen_string_literal: true

class Vote < ApplicationRecord
  belongs_to :item, polymorphic: true
end
