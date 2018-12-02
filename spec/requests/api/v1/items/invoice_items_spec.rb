require 'rails_helper'

describe 'Invoices Invoice Items API' do
  it "returns all invoice items for an Invoice " do
    merchant = create(:merchant)
   customer = create(:customer)
   item = create(:item, merchant_id: merchant.id)
   invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
   create_list(:invoice_item, 4, item_id: item.id, invoice_id: invoice.id)

   get "/api/v1/items/#{item.id}/invoice_items"

   expect(response).to be_successful

    # expect(response).to be_successful
    # expect(invoice_items["data"].count).to eq(2)
    # expect(invoice_items["data"].first["id"]).to eq(invoice_item_1.id.to_s)
    # expect(invoice_items["data"].last["id"]).to eq(invoice_item_2.id.to_s)
    # expect(invoice_items["data"]).not_to include(invoice_item_3.id.to_s)
  end
end
