FactoryBot.define do
  factory :customer do
    name {Faker::Commerce.product_name}
    description {"Description"}
    unit_price {Faker::Number.decimal(l_digits: 2)}
    merchant_id {1}
  end
end
