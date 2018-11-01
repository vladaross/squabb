class AddContentToArguments < ActiveRecord::Migration[5.2]
  def change
    add_column :arguments, :content, :string
  end
end
