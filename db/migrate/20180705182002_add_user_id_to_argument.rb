class AddUserIdToArgument < ActiveRecord::Migration[5.2]
  def change
    add_column :arguments, :user_id, :integer
  end
end
