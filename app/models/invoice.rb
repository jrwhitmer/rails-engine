class Invoice < ApplicationRecord
  validates :customer_id, presence: true
  validates :merchant_id, presence: true
  validates :status, presence: true
  belongs_to :customer
  belongs_to :merchant
  has_many :transactions
  has_many :invoice_items
end
