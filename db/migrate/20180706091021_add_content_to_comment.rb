class AddContentToComment < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :content, :string
  end
end
