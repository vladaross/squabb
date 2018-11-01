# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'replies/edit', type: :view do
  before(:each) do
    @reply = assign(:reply, Reply.create!(
                              content: '',
                              comment_id: 1
                            ))
  end

  it 'renders the edit reply form' do
    render

    assert_select 'form[action=?][method=?]', reply_path(@reply), 'post' do
      assert_select 'input[name=?]', 'reply[content]'

      assert_select 'input[name=?]', 'reply[comment_id]'
    end
  end
end
