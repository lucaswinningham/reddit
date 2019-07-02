class CreateSubs < ActiveRecord::Migration[5.1]
  def change
    create_table :subs do |t|
      t.string :name
      t.boolean :active

      t.timestamps
    end
    add_index :subs, :name, unique: true
  end
end
