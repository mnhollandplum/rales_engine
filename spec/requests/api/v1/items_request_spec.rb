require 'rails_helper'
describe "Items API" do

  before(:each) do
    @merchant = create(:merchant)

    @item_1 = create(:item, merchant_id: @merchant.id)
    @item_2 = create(:item, merchant_id: @merchant.id)
    @item_3 = create(:item, merchant_id: @merchant.id)
  end

  it "sends a list of items" do

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(3)
  end

  it "can get one item by it's id" do
    id = @item_1.id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"]["id"]).to eq(id.to_s)
  end

  it "can find an item by id" do
    id = @item_1.id

    get "/api/v1/items/find?id=#{id}"

    item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(item["data"]["id"]).to eq(id.to_s)
  end

end
