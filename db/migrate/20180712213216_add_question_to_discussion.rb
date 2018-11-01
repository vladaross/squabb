class AddQuestionToDiscussion < ActiveRecord::Migration[5.2]
  def change
  	add_column :discussions, :question, :string
  end
end
