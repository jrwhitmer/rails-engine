require 'rails_helper'

RSpec.describe "Merchants", type: :request do
  it 'can return the total revenue for a merchant' do
    @merchant = Merchant.create!(name: "Tyler")
    @item = @merchant.items.create!(name: "socks", description: "soft", unit_price: 3.00)
    @customer = Customer.create!(first_name: "Dr.", last_name: "Pepper")

    @invoice1 = @customer.invoices.create!(status: 2, created_at: "2012-03-21 09:54:09", merchant_id: @merchant.id)
    @invoice2 = @customer.invoices.create!(status: 2, created_at: "2012-04-21 09:54:09", merchant_id: @merchant.id)

    @transaction1 = @invoice1.transactions.create!(result: 1, credit_card_number: 4654405418249632, credit_card_expiration_date: "1022")
    @transaction2 = @invoice1.transactions.create!(result: 1, credit_card_number: 4580251236515201, credit_card_expiration_date: "1022")
    @transaction3 = @invoice2.transactions.create!(result: 1, credit_card_number: 4923661117104166, credit_card_expiration_date: "1022")
    @transaction4 = @invoice2.transactions.create!(result: 0, credit_card_number: 4515551623735607, credit_card_expiration_date: "1022")

    @invoice_item1 = @item.invoice_items.create!(quantity: 6, unit_price: 3.0, invoice: @invoice1)
    @invoice_item2 = @item.invoice_items.create!(quantity: 1, unit_price: 400.0, invoice: @invoice1)

    get "/api/v1/merchants/#{@merchant.id}"

    expect(response).to be_successful

    returned_merchant = JSON.parse(response.body, symbolize_names: true)
    require 'pry'; binding.pry
    expect(returned_merchant[:total_revenue]).to eq(500)
  end
end
