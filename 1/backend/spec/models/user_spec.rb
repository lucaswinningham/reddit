require 'rails_helper'
require 'shared/concerns/an_activatable'

RSpec.describe User, type: :model do
  it_behaves_like 'an activatable'

  invalid_names = ['username!', 'username?', 'username*', 'username#', 'user name']
  valid_names = ['username', 'user-name', 'user_name', 'user1name', '_username_', '-username-',
                 '1username1', 'USERNAME']

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_length_of(:name).is_at_least(3).is_at_most(20) }
  it { should_not allow_values(*blank_values).for(:name) }
  it { should_not allow_values(*invalid_names).for(:name) }
  it { should allow_values(*valid_names).for(:name) }

  it { should have_many(:posts) }
  describe 'posts' do
    context 'on deactivate' do
      it 'should deactivate associated posts' do
        post = create :post
        post.user.deactivate
        post.reload
        expect(post.active).to be false
      end
    end
  end

  describe 'to_param' do
    it 'overrides #to_param with name attribute' do
      existing_user = create :user
      expect(existing_user.to_param).to eq(existing_user.name)
    end
  end

  it { should have_many(:comments) }
  describe 'comments' do
    context 'on deactivate' do
      it 'should deactivate associated comments' do
        comment = create :comment
        comment.user.deactivate
        comment.reload
        expect(comment.active).to be false
      end
    end
  end

  it { should have_one(:salt) }
  describe 'salt' do
    context 'on create' do
      it 'should create associated salt' do
        expect { create :user, salt: nil }.to change { Salt.count }.by(1)
      end
    end
  end

  it { should have_one(:nonce) }

  it { should have_one(:activation) }
  describe 'activation' do
    context 'on create' do
      it 'should create associated activation' do
        expect { create :user, activation: nil }.to change { Activation.count }.by(1)
      end
    end
  end

  describe '#authenticate' do
    # TODO: fill out
  end

  describe '#hashed_password=' do
    # TODO: fill out
  end

  describe '#password=' do
    # TODO: fill out
  end
end
