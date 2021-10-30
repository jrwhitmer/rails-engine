require 'rails_helper'
describe 'Items API' do
  it 'can create a new item' do
    merchant = Merchant.create(id: 1, name: "Merchant Name")
    item_params = ({name: "Item Name", description: "Item Description", unit_price: 1.1, merchant_id: 1})
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)

    created_item = Item.last

    expect(response).to be_successful
    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
    expect(created_item.merchant_id).to eq(item_params[:merchant_id])
  end

  it 'can update an existing book' do
      merchant = Merchant.create(id: 1, name: "Merchant Name")
      id = create(:item).id
      previous_name = Item.last.name
      item_params = { name: "Item Name"}
      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})
      item = Item.find_by(id: id)

      expect(response).to be_successful
      expect(item.name).to_not eq(previous_name)
      expect(item.name).to eq("Item Name")
    end
end
