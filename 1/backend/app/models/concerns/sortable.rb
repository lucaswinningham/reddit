module Sortable
  extend ActiveSupport::Concern

  module ClassMethods
    def sort
      order('up_votes_count - dn_votes_count DESC')
    end
  end
end
