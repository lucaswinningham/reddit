require 'rails_helper'

RSpec.describe Vote, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:voteable) }

  it { should allow_values(nil, true, false).for(:direction) }

  describe 'voteable votes counts' do
    context 'on create' do
      it 'should initialize up_votes_count and dn_votes_count' do
        vote = create :vote, direction: false
        expect(vote.voteable.upvotes).to eq(0)
        expect(vote.voteable.dnvotes).to eq(1)

        vote = create :vote
        expect(vote.voteable.upvotes).to eq(0)
        expect(vote.voteable.dnvotes).to eq(0)

        vote = create :vote, direction: true
        expect(vote.voteable.upvotes).to eq(1)
        expect(vote.voteable.dnvotes).to eq(0)
      end
    end

    context 'on update' do
      context 'when direction unchanged' do
        it 'should not change up_votes_count and dn_votes_count' do
          [false, nil, true].each do |dir|
            vote = create :vote, direction: dir
            expect { vote.update direction: dir }.to change { vote.voteable.upvotes }.by(0)
            expect { vote.update direction: dir }.to change { vote.voteable.dnvotes }.by(0)
          end
        end
      end

      context 'when direction was nil' do
        let(:vote) { create :vote }

        context 'when direction to update to false' do
          it 'should increment dn_votes_count' do
            expect { vote.update direction: false }.to change { vote.voteable.dnvotes }.by(1)
          end
        end

        context 'when direction to update to true' do
          it 'should increment up_votes_count' do
            expect { vote.update direction: true }.to change { vote.voteable.upvotes }.by(1)
          end
        end
      end

      context 'when direction was false' do
        let(:vote) { create :vote, direction: false }

        context 'when direction to update to nil' do
          it 'should decrement dn_votes_count' do
            expect { vote.update direction: nil }.to change { vote.voteable.dnvotes }.by(-1)
          end
        end

        context 'when direction to update to true' do
          it 'should decrement dn_votes_count' do
            expect { vote.update direction: true }.to change { vote.voteable.dnvotes }.by(-1)
          end

          it 'should increment up_votes_count' do
            expect { vote.update direction: true }.to change { vote.voteable.upvotes }.by(1)
          end
        end
      end

      context 'when direction was true' do
        let(:vote) { create :vote, direction: true }

        context 'when direction to update to nil' do
          it 'should decrement up_votes_count' do
            expect { vote.update direction: nil }.to change { vote.voteable.upvotes }.by(-1)
          end
        end

        context 'when direction to update to false' do
          it 'should decrement up_votes_count' do
            expect { vote.update direction: false }.to change { vote.voteable.upvotes }.by(-1)
          end

          it 'should increment dn_votes_count' do
            expect { vote.update direction: false }.to change { vote.voteable.dnvotes }.by(1)
          end
        end
      end
    end
  end
end
