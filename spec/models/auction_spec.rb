require 'rails_helper'

RSpec.describe Auction, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:startTime) }
    it { should validate_presence_of(:endTime) }
    it { should validate_presence_of(:currentPrice) }
    it { should validate_numericality_of(:currentPrice).is_greater_than_or_equal_to(0) }
    it { should validate_presence_of(:status) }
    it { should validate_inclusion_of(:status).in_array(%w[pending active ended cancelled declined]) }
  end

  describe 'associations' do
    it { should belong_to(:item) }
    it { should have_many(:bids) }
    it { should have_one(:payment) }
  end

  describe 'custom validations' do
    it 'ensures end time is after start time' do
      auction = Auction.new(startTime: Time.now, endTime: 1.day.ago)
      auction.valid?
      expect(auction.errors[:endTime]).to include('must be after the start time')
    end
  end
end
