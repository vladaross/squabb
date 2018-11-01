# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'comments/show', type: :view do
  before(:each) do
    @comment = assign(:comment, Comment.create!(
                                  content: '',
                                  user_id: '',
                                  discussion_id: 2
                                ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
  end
end
