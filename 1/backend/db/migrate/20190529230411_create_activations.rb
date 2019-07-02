class CreateActivations < ActiveRecord::Migration[5.1]
  def change
    create_table :activations do |t|
      t.references :user, foreign_key: true
      t.string :digest

      t.timestamps
    end
  end
end
