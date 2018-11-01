# frozen_string_literal: true

class DiscussionsMembersWorker
  def self.create(discussion_id, user_id, side)
    return nil if record_already_exist?(discussion_id, user_id)
    Discussion.side_inc(discussion_id, side)
    DiscussionsMember.create(discussion_id: discussion_id, user_id: user_id, side: side)
  end

  def self.record_already_exist?(discussion_id, user_id)
    return true if DiscussionsMember.exists?(user_id: user_id, discussion_id: discussion_id)
    false
  end

  def self.get_users_side(discussion_id, user_id)
    return nil unless DiscussionsMember.exists?(user_id: user_id, discussion_id: discussion_id)
    DiscussionsMember.where(user_id: user_id, discussion_id: discussion_id).first.read_attribute(:side)
  end

  def self.count_users_by_side(discussion_id, side)
    DiscussionsMember.where(discussion_id: discussion_id, side: side).count
  end
end
