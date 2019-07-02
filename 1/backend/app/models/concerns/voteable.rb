module Voteable
  extend ActiveSupport::Concern

  alias_attribute :upvotes, :up_votes_count
  alias_attribute :dnvotes, :dn_votes_count

  included do
    before_create :initialize_votes_counts
  end

  def inc_up_votes
    increment! :up_votes_count
  end

  def dec_up_votes
    decrement! :up_votes_count
  end

  def inc_dn_votes
    increment! :dn_votes_count
  end

  def dec_dn_votes
    decrement! :dn_votes_count
  end

  private

  def initialize_votes_counts
    self.up_votes_count = 0
    self.dn_votes_count = 0
  end
end
