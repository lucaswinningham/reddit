class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.text :title
      t.string :url
      t.text :body
      t.boolean :active
      t.string :token

      t.timestamps
    end
    add_index :posts, :url, unique: true
    add_index :posts, :token, unique: true
  end
end
