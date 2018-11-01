# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'replies/new', type: :view do
  before(:each) do
    assign(:reply, Reply.new(
                     content: '',
                     comment_id: 1
                   ))
  end

  it 'renders new reply form' do
    render

    assert_select 'form[action=?][method=?]', replies_path, 'post' do
      assert_select 'input[name=?]', 'reply[content]'

      assert_select 'input[name=?]', 'reply[comment_id]'
    end
  end
end
