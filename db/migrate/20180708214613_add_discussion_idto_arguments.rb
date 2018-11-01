class AddDiscussionIdtoArguments < ActiveRecord::Migration[5.2]
  def change
  	add_column :arguments, :discussion_id, :integer
  end
end
