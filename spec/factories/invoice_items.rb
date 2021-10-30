FactoryBot.define do
  factory :invoice_item do
    item_id {1}
    invoice_id {1}
    quantity { Faker::Number.number(digits: 2)}
    unit_price {Faker::Number.decimal(l_digits: 2)}
  end
end
