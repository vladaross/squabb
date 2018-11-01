# frozen_string_literal: true

require 'rails_helper'
require './app/services/discussions_members_worker'

RSpec.describe 'DiscussionMembersWorker' do
  # Initialize the test data
  let!(:user) { create(:user) }
  let!(:category) { create(:category) }
  let!(:discussion) { create(:discussion, user_id: user.id, category_id: category.id) }

  describe 'DiscussionMembers.create' do
    context 'when user, discussion exists and record don\'t exist' do
      it 'has correct attributes' do
        expect(DiscussionsMembersWorker.create(discussion.id, user.id, 'right')).to have_attributes(discussion_id:
          discussion.id, user_id: user.id, side: 'right')
      end
    end

    context 'when we alredy have valid record' do
      it 'returns nil' do
        DiscussionsMembersWorker.create(discussion.id, user.id, 'right')
        expect(DiscussionsMembersWorker.create(discussion.id, user.id, 'right')).to be_nil
      end
    end
  end
end
