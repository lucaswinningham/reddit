class CreateNonces < ActiveRecord::Migration[5.1]
  def change
    create_table :nonces do |t|
      t.references :user, foreign_key: true
      t.string :value
      t.datetime :expires_at

      t.timestamps
    end
  end
end
