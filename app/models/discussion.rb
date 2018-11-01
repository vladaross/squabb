# frozen_string_literal: true

class Discussion < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many   :arguments, dependent: :destroy
  has_many :votes, as: :item

  validates :left_side, :right_side, presence: true
  validates :left_side, :right_side, length: { in: 1..80 }
  validates :question, length: { in: 0..120 }

  def self.side_inc(id, side)
    discussion = Discussion.find(id)
    discussion.increment!("#{side}_counter")
  end

  def self.search(search)
    if search
      where(['right_side LIKE ?', search]).or(Discussion.where(['left_side LIKE ?', search])).or(Discussion.where(['question LIKE ?', search]))
    else
      find(:all)
    end
  end
  resourcify
end
