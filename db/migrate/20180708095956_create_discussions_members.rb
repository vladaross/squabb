class CreateDiscussionsMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :discussions_members do |t|
      t.integer :discussion_id, null: false
      t.integer :user_id, null: false
      t.string :side

      t.timestamps
    end
  end
end
