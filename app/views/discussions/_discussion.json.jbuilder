# frozen_string_literal: true

json.extract! discussion, :id, :left_side, :right_side, :category_id, :created_at, :updated_at
json.url discussion_url(discussion, format: :json)
