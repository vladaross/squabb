class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.integer :value
      t.integer :item_id
      t.string  :item_type

      t.timestamps
    end
  end
end
