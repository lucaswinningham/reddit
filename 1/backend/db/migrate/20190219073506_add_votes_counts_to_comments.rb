class AddVotesCountsToComments < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :up_votes_count, :integer
    add_column :comments, :dn_votes_count, :integer
  end
end
