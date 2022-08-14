class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.text :title, null: false
      t.text :purpose, null: false
      t.float :star, null: false
      t.string :body

      t.timestamps
    end
  end
end
