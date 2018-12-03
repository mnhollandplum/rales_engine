require 'rails_helper'

describe "Invoices API" do
  before(:each) do
    @customer = create(:customer)
    @merchant = create(:merchant)

    @invoice_1 = create(:invoice, customer_id: @customer.id, merchant_id: @merchant.id)
    @invoice_2 = create(:invoice, customer_id: @customer.id, merchant_id: @merchant.id)
    @invoice_3 = create(:invoice, customer_id: @customer.id, merchant_id: @merchant.id, created_at: Time.now + 100)

  it "sends a list of invoices" do

    get '/api/v1/invoices'

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices["data"].count).to eq(3)
  end
    it "can get one invoice show" do

      id = create(:invoice, customer_id: @customer.id, merchant_id: @merchant.id).id

      get "/api/v1/invoices/#{id}"

      invoice = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice["data"]["id"]).to eq(id.to_s)
    end

    it "can find a invoice item by id" do
      id = create(:invoice, customer_id: @customer.id, merchant_id: @merchant.id).id

      get "/api/v1/invoices/find?id=#{id}"

      invoice = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice["data"]["attributes"]["id"]).to eq(id)
    end

    it "can find all invoices with the same attribute" do

      get "/api/v1/invoices/find_all?id=#{@invoice_1.created_at}"

      invoices = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoices["data"].count).to eq(3)
      expect(invoices["data"].first["attributes"]["id"]).to eq(@invoice_1.id)
      expect(invoices["data"].first["attributes"]["id"]).to eq(@invoice_2.id)
      expect(invoices["data"].first["attributes"]["id"]).to eq(@invoice_3.id)
    end
  end

end
