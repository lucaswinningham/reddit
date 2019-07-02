require 'rails_helper'
require 'shared/concerns/an_activatable'

RSpec.describe Sub, type: :model do
  it_behaves_like 'an activatable'

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).case_insensitive }
  it { should validate_length_of(:name).is_at_least(3).is_at_most(21) }
  it { should_not allow_values(*blank_values).for(:name) }
  it { should_not allow_values(*invalid_sub_names).for(:name) }
  it { should allow_values(*valid_sub_names).for(:name) }

  it { should have_many(:posts) }
end
