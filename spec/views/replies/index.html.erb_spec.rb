# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'replies/index', type: :view do
  before(:each) do
    assign(:replies, [
             Reply.create!(
               content: '',
               comment_id: 2
             ),
             Reply.create!(
               content: '',
               comment_id: 2
             )
           ])
  end

  it 'renders a list of replies' do
    render
    assert_select 'tr>td', text: ''.to_s, count: 2
    assert_select 'tr>td', text: 2.to_s, count: 2
  end
end
