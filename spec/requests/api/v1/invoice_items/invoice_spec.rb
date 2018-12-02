require 'rails_helper'

describe 'Invoice Items Invoice API' do
  it "returns the invoice for a invoice item" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)

    customer_1 = create(:customer)
    customer_2 = create(:customer)
    customer_3 = create(:customer)

    invoice_1 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer_1.id)
    invoice_2 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer_2.id)

    item_1 = create(:item, merchant_id: merchant_1.id)
    item_2 = create(:item, merchant_id: merchant_1.id)

    invoice_item_1 = create(:invoice_item, invoice_id: invoice_1.id, item_id: item_1.id)
    invoice_item_2 = create(:invoice_item, invoice_id: invoice_2.id, item_id: item_2.id)

    get "/api/v1/invoice_items/#{invoice_item_1.id}/invoice"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice.count).to eq(1)
    expect(invoice["data"]["id"]).to eq(invoice_1.id.to_s)

    get "/api/v1/invoice_items/#{invoice_item_2.id}/invoice"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice.count).to eq(1)
    expect(invoice["data"]["id"]).to eq(invoice_2.id.to_s)
  end
end
