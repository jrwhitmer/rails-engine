class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true
  validates :merchant_id, presence: true
  belongs_to :merchant
  has_many :invoice_items

  def self.find_one_by_name(name)
    where('name ILIKE ?', "%#{name}%").order(:name).first
  end

  def self.find_one_by_min(min)
    where("unit_price >= ?", min).order(:name).first
  end

  def self.find_one_by_max(max)
    where("unit_price <= ?", max).order(:name).first
  end

  def self.find_one_by_min_max(min, max)
    where("unit_price > ? AND unit_price < ?", min, max).order(:name).first
  end
end
