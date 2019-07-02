class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :voteable, polymorphic: true

  before_save :update_votes_counts

  private

  def update_votes_counts
    return unless direction_changed?

    handle_up_votes
    handle_dn_votes
  end

  def handle_up_votes
    voteable.inc_up_votes if direction == true
    voteable.dec_up_votes if direction_was == true
  end

  def handle_dn_votes
    voteable.inc_dn_votes if direction == false
    voteable.dec_dn_votes if direction_was == false
  end
end
