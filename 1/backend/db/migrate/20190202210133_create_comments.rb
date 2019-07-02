class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.references :user, foreign_key: true
      t.text :content
      t.boolean :active
      t.references :commentable, polymorphic: true
      t.string :token

      t.timestamps
    end
    add_index :comments, :token, unique: true
  end
end
