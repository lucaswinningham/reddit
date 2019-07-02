require 'rails_helper'
require 'shared/concerns/an_activatable'
require 'shared/concerns/a_sortable'
require 'shared/concerns/a_tokenable'
require 'shared/concerns/a_voteable'

RSpec.describe Post, type: :model do
  it_behaves_like 'an activatable'
  it_behaves_like 'a sortable'
  it_behaves_like 'a tokenable'
  it_behaves_like 'a voteable'

  it { should validate_presence_of(:title) }
  it { should validate_length_of(:title).is_at_most(256) }
  it { should_not allow_values(*blank_values).for(:title) }

  it { should validate_length_of(:body).is_at_most(10_000) }

  it { should validate_uniqueness_of(:url) }
  it { should_not allow_values(*invalid_urls).for(:url) }
  it { should allow_values(*valid_urls).for(:url) }

  it { should belong_to(:sub) }

  it { should belong_to(:user) }

  it { should have_many(:comments) }
end
