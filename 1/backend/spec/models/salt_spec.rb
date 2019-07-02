require 'rails_helper'

RSpec.describe Salt, type: :model do
  it { should belong_to(:user) }

  context 'on create' do
    it 'should populate value' do
      salt = create :salt, value: nil
      expect(salt.value).to be_truthy
    end
  end
end
