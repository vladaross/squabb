# frozen_string_literal: true

class VotesController < ApplicationController
  before_action :set_discussion, only: %i[like dislike]
  before_action :authenticate_user!

  def like
    get_vote
    @vote.value += 1 unless @vote.value == 1
    @vote.save
    respond_to do |format|
      format.html { redirect_to @discussion }
    end
  end

  def dislike
    get_vote
    @vote.value -= 1 unless @vote.value == -1
    @vote.save
    respond_to do |format|
      format.html { redirect_to @discussion }
    end
  end

  private

  def get_vote
    current_item = get_item_by_type(params[:item_id], params[:item_type])
    @vote = current_item.votes.find_by_user_id(current_user.id)
    unless @vote
      @vote = Vote.create(user_id: current_user.id, value: 0)
      current_item.votes << @vote
    end
  end

  def get_item_by_type(id, type)
    case type
    when 'Argument'
      item = Argument.find(id)
    when 'Reply'
      item = Reply.find(id)
    when 'Discussion'
      item = Discussion.find(id)
    end
    item
  end

  def set_discussion
    @discussion = Discussion.find(params[:id])
  end
end
