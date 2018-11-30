require 'rails_helper'

describe 'Invoices Items API' do
  it "returns all Items for an Invoice " do
    merchant_1 = create(:merchant)

    customer_1 = create(:customer)

    invoice_1 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer_1.id)
    invoice_2 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer_1.id)

    item_1 = create(:item, merchant_id: merchant_1.id)
    item_2 = create(:item, merchant_id: merchant_1.id)

    invoice_item_1 = create(:invoice_item, invoice_id: invoice_1.id, item_id: item_1.id)
    invoice_item_2 = create(:invoice_item, invoice_id: invoice_1.id, item_id: item_2.id)
    invoice_item_3 = create(:invoice_item, invoice_id: invoice_2.id, item_id: item_2.id)


    get "/api/v1/invoices/#{invoice_1.id}/items"

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items["data"].count).to eq(2)
    expect(items["data"].first["id"]).to eq(item_1.id.to_s)
    expect(items["data"].last["id"]).to eq(item_2.id.to_s)
  end
end
