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

  it 'can update an existing item' do
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

  it 'can find a single item by name, returns first result (alphabetically)' do
    merchant = Merchant.create(id: 1, name: "Merchant Name")
    item_1 = Item.create(name: "zitem", description: "description", unit_price: 1.2, merchant_id: 1)
    item_2 = Item.create(name: "aitem", description: "description", unit_price: 1.5, merchant_id: 1)
    item_3 = Item.create(name: "button", description: "description", unit_price: 1.4, merchant_id: 1)

    get "/api/v1/items/find?name=item"

    expect(response).to be_successful

    returned_item = JSON.parse(response.body, symbolize_names: true)

    expect(returned_item[:name]).to eq("aitem")
  end
end
