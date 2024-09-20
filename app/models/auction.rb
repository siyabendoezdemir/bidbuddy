class Auction < ApplicationRecord
  belongs_to :item
  has_many :bids
  has_one :payment

  validates :startTime, presence: true
  validates :endTime, presence: true
  validates :currentPrice, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :status, presence: true, inclusion: { in: %w[pending active ended cancelled declined] }

  validate :end_time_after_start_time

  private

  def end_time_after_start_time
    if endTime && startTime && endTime <= startTime
      errors.add(:endTime, "must be after the start time")
    end
  end
end
