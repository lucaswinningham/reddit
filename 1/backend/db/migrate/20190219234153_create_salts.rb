class CreateSalts < ActiveRecord::Migration[5.1]
  def change
    create_table :salts do |t|
      t.references :user, foreign_key: true
      t.string :value

      t.timestamps
    end
  end
end
