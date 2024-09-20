class Item < ApplicationRecord
  belongs_to :seller, class_name: "Account"
  has_one :auction

  validates :name, presence: true
  validates :description, presence: true
  validates :startingPrice, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
