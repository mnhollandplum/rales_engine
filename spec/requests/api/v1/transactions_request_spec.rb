require 'rails_helper'

describe "Transactions API" do
  it "sends a list of transactions" do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    create_list(:transaction, 3, invoice_id: invoice.id)

    get '/api/v1/transactions'

    expect(response).to be_successful

    transactions = JSON.parse(response.body)

    expect(transactions.count).to eq(3)
  end
    it "can get one transaction by it's id" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      id = create(:transaction, invoice_id: invoice.id).id

      get "/api/v1/transactions/#{id}"

      transaction = JSON.parse(response.body)

      expect(response).to be_successful
      expect(transaction["id"]).to eq(id)
    end

end
