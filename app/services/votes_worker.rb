# frozen_string_literal: true

class VotesWorker
  def self.get_likes(id, type)
    return nil unless Vote.exists?(item_id: id, item_type: type, value: 1)
    Vote.where(item_id: id, item_type: type, value: 1).count(:value) # you can also use .sum
  end

  def self.get_dislikes(id, type)
    return nil unless Vote.exists?(item_id: id, item_type: type, value: -1)
    Vote.where(item_id: id, item_type: type, value: -1).count(:value) # you can also use .sum
  end
end
