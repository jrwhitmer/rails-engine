class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true
  validates :merchant_id, presence: true
  belongs_to :merchant
  has_many :invoice_items

  def self.find_one_by_name(name)
    Item.where('name ILIKE ?', "%#{name}%").order(:name).first
  end
end
