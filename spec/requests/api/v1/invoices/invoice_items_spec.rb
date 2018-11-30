require 'rails_helper'

describe 'Invoices Transactions API' do
  it "returns all transactions for an Invoice " do
    merchant_1 = create(:merchant)

    customer_1 = create(:customer)

    invoice_1 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer_1.id)
    invoice_2 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer_1.id)

    item_1 = create(:item, merchant_id: merchant_1.id)
    item_2 = create(:item, merchant_id: merchant_1.id)

    invoice_item_1 = create(:invoice_item, invoice_id: invoice_1.id, item_id: item_1.id)
    invoice_item_2 = create(:invoice_item, invoice_id: invoice_1.id, item_id: item_2.id)
    invoice_item_3 = create(:invoice_item, invoice_id: invoice_2.id, item_id: item_2.id)


    get "/api/v1/invoices/#{invoice_1.id}/invoice_items"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_items["data"].count).to eq(2)
    expect(invoice_items["data"].first["id"]).to eq(invoice_item_1.id.to_s)
    expect(invoice_items["data"].last["id"]).to eq(invoice_item_2.id.to_s)
    expect(invoice_items["data"]).not_to include(invoice_item_3.id.to_s)
  end
end
