# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'comments/index', type: :view do
  before(:each) do
    assign(:comments, [
             Comment.create!(
               content: '',
               user_id: '',
               discussion_id: 2
             ),
             Comment.create!(
               content: '',
               user_id: '',
               discussion_id: 2
             )
           ])
  end

  it 'renders a list of comments' do
    render
    assert_select 'tr>td', text: ''.to_s, count: 2
    assert_select 'tr>td', text: ''.to_s, count: 2
    assert_select 'tr>td', text: 2.to_s, count: 2
  end
end
