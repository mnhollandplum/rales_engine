require 'rails_helper'

describe "Invoices API" do
  it "sends a list of invoices" do
    customer = create(:customer)
    merchant = create(:merchant)

    create_list(:invoice, 3, customer_id: customer.id, merchant_id: merchant.id)

    get '/api/v1/invoices'

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices["data"].count).to eq(3)
  end
    it "can get one invoice by it's id" do
      customer = create(:customer)
      merchant = create(:merchant)
      id = create(:invoice, customer_id: customer.id, merchant_id: merchant.id).id

      get "/api/v1/invoices/#{id}"

      invoice = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice["data"]["id"]).to eq(id.to_s)
    end

end
