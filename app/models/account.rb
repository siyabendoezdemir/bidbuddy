class Account < ApplicationRecord
  has_secure_password

  has_many :items, foreign_key: :seller_id
  has_many :bids, foreign_key: :bidder_id
  has_many :payments, foreign_key: :buyer_id

  validates :displayName, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 12 }, if: -> { new_record? || !password.nil? }
  validates :role, presence: true, inclusion: { in: %w[buyer seller admin] }

  normalizes :email, with: -> { _1.strip.downcase }

  before_save :downcase_email

  private

  def downcase_email
    self.email = email.downcase if email.present?
  end
end
