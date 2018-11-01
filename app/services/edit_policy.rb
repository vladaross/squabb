# frozen_string_literal: true

class EditPolicy
  TIME_FOR_EDITING = 300

  def self.argument_can_be_edited?(argument, user)
    return false unless own_argument?(argument, user)
    time_diff = (Time.current - argument.created_at)
    time_diff <= TIME_FOR_EDITING
  end

  def self.reply_can_be_edited?(reply, user)
    return false unless own_reply?(reply, user)
    time_diff = (Time.current - reply.created_at)
    time_diff <= TIME_FOR_EDITING
  end

  def self.discussion_can_be_edited?(discussion, user)
    return false unless own_discussion?(discussion, user)
    time_diff = (Time.current - discussion.created_at)
    time_diff <= TIME_FOR_EDITING
  end

  def self.own_reply?(reply, user)
    user == reply.user
  end

  def self.own_argument?(argument, user)
    user == argument.user
  end

  def self.own_discussion?(discussion, user)
    user == discussion.user
  end
end
