class Payment < ApplicationRecord
  belongs_to :auction
  belongs_to :buyer, class_name: "Account"

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :status, presence: true, inclusion: { in: %w[pending completed failed] }
  validates :timestamp, presence: true
end
