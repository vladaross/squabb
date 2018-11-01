class AddCategoryIdToDiscussion < ActiveRecord::Migration[5.2]
  def change
    add_column :discussions, :category_id, :integer
  end
end
