class InvoiceItem < ApplicationRecord
  validates :item_id, presence: true
  validates :invoice_id, presence: true
  validates :quantity, presence: true
  validates :unit_price, presence: true
  belongs_to :invoice
  belongs_to :item
end
