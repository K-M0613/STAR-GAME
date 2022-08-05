class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.integer :game_id, null: false
      t.text :purpose, null: false
      t.string :star, null: false
      t.string :commemt, null: false

      t.timestamps
    end
  end
end
