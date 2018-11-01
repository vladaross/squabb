# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'replies/show', type: :view do
  before(:each) do
    @reply = assign(:reply, Reply.create!(
                              content: '',
                              comment_id: 2
                            ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
  end
end
