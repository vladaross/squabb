class ChangeColumnsType < ActiveRecord::Migration[5.2]
  def change
  	change_column :replies, :content, :text
  	change_column :arguments, :content, :text
  end
end
