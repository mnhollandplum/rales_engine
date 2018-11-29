require 'rails_helper'

describe 'Merchants Items API' do
  it "returns all items for a merchant" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)

    item_1 = create(:item, merchant_id: merchant_1.id)
    item_2 = create(:item, merchant_id: merchant_1.id)
    item_3 = create(:item, merchant_id: merchant_2.id)

    get "/api/v1/merchants/#{merchant_1.id}/items"

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items["data"].count).to eq(2)
    expect(items["data"].first["id"]).to eq(item_1.id.to_s)
    expect(items["data"].last["id"]).to eq(item_2.id.to_s)
    expect(items["data"]).not_to include(item_3.id.to_s)
  end
end
