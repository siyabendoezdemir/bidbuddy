# app/models/bid.rb

class Bid < ApplicationRecord
  belongs_to :auction
  belongs_to :bidder, class_name: "Account"

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :timestamp, presence: true

  validate :amount_greater_than_current_price

  private

  def amount_greater_than_current_price
    if auction && amount <= auction.currentPrice
      errors.add(:amount, "must be greater than the current auction price")
    end
  end
end
