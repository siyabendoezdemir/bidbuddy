require 'rails_helper'

RSpec.describe Account, type: :model do
  describe 'validations' do
    subject { build(:account) }  # Use FactoryBot to build a valid account

    it { should validate_presence_of(:displayName) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }

    # Replace the simple password presence validation with a more specific test
    it 'requires a password on create' do
      account = build(:account, password: nil)
      expect(account).to_not be_valid
      expect(account.errors[:password]).to include("can't be blank")
    end

    it { should validate_length_of(:password).is_at_least(12) }
    it { should validate_presence_of(:role) }
    it { should validate_inclusion_of(:role).in_array(%w[buyer seller admin]) }
  end

  describe 'associations' do
    it { should have_many(:items).with_foreign_key(:seller_id) }
    it { should have_many(:bids).with_foreign_key(:bidder_id) }
    it { should have_many(:payments).with_foreign_key(:buyer_id) }
  end

  describe 'callbacks' do
    it 'downcases email before saving' do
      account = create(:account, email: 'TEST@EXAMPLE.COM')
      expect(account.email).to eq('test@example.com')
    end
  end
end
