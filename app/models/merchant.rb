class Merchant < ApplicationRecord
  validates :name, presence: true
  has_many :invoices
  has_many :items

  def self.total_revenue(id)
    joins(items: {invoice_items: {invoice: :transactions}})
    .select("merchants.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS total_revenue")
    .where("transactions.result = ? AND merchants.id = ?", "success", id)
    .where("invoices.status = ?", "shipped")
    .group("merchants.id")
    .first
  end
end
