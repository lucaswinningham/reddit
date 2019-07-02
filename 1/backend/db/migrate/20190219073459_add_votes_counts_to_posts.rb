class AddVotesCountsToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :up_votes_count, :integer
    add_column :posts, :dn_votes_count, :integer
  end
end
