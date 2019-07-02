require 'rails_helper'
require 'shared/concerns/an_activatable'
require 'shared/concerns/a_sortable'
require 'shared/concerns/a_tokenable'
require 'shared/concerns/a_voteable'

RSpec.describe Comment, type: :model do
  it_behaves_like 'an activatable'
  it_behaves_like 'a sortable'
  it_behaves_like 'a tokenable'
  it_behaves_like 'a voteable'

  it { should belong_to(:user) }
  it { should belong_to(:commentable) }

  it { should have_many(:comments) }

  it { should validate_presence_of(:content) }
  it { should validate_length_of(:content).is_at_most(10_000) }
  it { should_not allow_values(*blank_values).for(:content) }
end
