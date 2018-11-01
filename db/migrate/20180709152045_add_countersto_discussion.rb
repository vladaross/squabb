class AddCounterstoDiscussion < ActiveRecord::Migration[5.2]
  def change
  	add_column :discussions, :right_counter, :integer, :null => false, :default => 0
  	add_column :discussions, :left_counter, :integer, :null => false, :default => 0

  end
end
