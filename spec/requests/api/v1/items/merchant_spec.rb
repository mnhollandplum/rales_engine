require 'rails_helper'

describe 'Item Merchant API' do
  it "returns the Merchant for an Item " do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)

    item_1 = create(:item, merchant_id: merchant_1.id)
    item_2 = create(:item, merchant_id: merchant_2.id)

    get "/api/v1/items/#{item_1.id}/merchant"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant.count).to eq(1)
    expect(merchant["data"]["id"]).to eq(merchant_1.id.to_s)

    get "/api/v1/items/#{item_2.id}/merchant"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant.count).to eq(1)
    expect(merchant["data"]["id"]).to eq(merchant_2.id.to_s)
  end
end
