class CreateDiscussions < ActiveRecord::Migration[5.2]
  def change
    create_table :discussions do |t|
      t.string :left_side
      t.string :right_side

      t.timestamps
    end
  end
end
