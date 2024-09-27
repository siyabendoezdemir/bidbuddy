require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:startingPrice) }
    it { should validate_numericality_of(:startingPrice).is_greater_than_or_equal_to(0) }
  end

  describe 'associations' do
    it { should belong_to(:seller).class_name('Account') }
    it { should have_one(:auction) }
  end
end
