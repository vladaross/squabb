# frozen_string_literal: true

module ApplicationHelper
  require 'redcarpet/render_strip'

  def has_role?(role)
    current_user&.has_role?(role)
  end
end
