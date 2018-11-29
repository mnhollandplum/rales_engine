require 'rails_helper'

describe "InvoiceItems API" do
  it "sends a list of Invoice Items" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant_id: merchant.id)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    create_list(:invoice_item, 3, item_id: item.id, invoice_id: invoice.id)

    get '/api/v1/invoice_items'

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items["data"].count).to eq(3)
  end
    it "can get one Invoice Item by it's id" do
      merchant = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant_id: merchant.id)
      invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
      create_list(:invoice_item, 3, item_id: item.id, invoice_id: invoice.id)
      id = create(:invoice_item, item_id: item.id, invoice_id: invoice.id).id


      get "/api/v1/invoice_items/#{id}"

      invoice_item = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice_item["data"]["id"]).to eq(id.to_s)
    end

end
