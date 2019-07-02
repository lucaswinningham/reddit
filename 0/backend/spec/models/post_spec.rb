require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'to_param' do
    it 'overrides #to_param with token attribute' do
      post = create :post
      expect(post.to_param).to eq(post.token)
    end
  end

  describe 'user' do
    it { should belong_to(:user) }
  end

  describe 'sub' do
    it { should belong_to(:sub) }
  end

  describe 'title' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(256) }
    it { should_not allow_values(*blank_values).for(:title) }
  end

  describe 'body' do
    it { should validate_length_of(:body).is_at_most(10_000) }
  end

  describe 'url' do
    it { should validate_uniqueness_of(:url) }
    it { should_not allow_values(*invalid_urls).for(:url) }
    it { should allow_values(*valid_urls).for(:url) }
  end

  describe 'active' do
    context 'on create' do
      it 'should be true' do
        post = create :post
        expect(post.active).to be true
      end
    end
  end

  describe 'token' do
    context 'on create' do
      it 'should populate' do
        post = create :post
        expect(post.token).to be_truthy
      end
    end
  end
end
