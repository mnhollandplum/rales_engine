require 'rails_helper'

describe "Transactions API" do
  before(:each) do
    @merchant = create(:merchant)
    @customer = create(:customer)
    @invoice = create(:invoice, merchant_id: @merchant.id, customer_id: @customer.id)

    @transaction_1 = create(:transaction, invoice_id: @invoice.id, created_at: "1990-04-13 04:30:00 UTC")
    @transaction_2 = create(:transaction, invoice_id: @invoice.id, created_at: "1990-04-13 04:30:00 UTC")
    @transaction_3 = create(:transaction, invoice_id: @invoice.id)
  end
  it "sends a list of transactions" do
    get '/api/v1/transactions'

    expect(response).to be_successful

    transactions = JSON.parse(response.body)

    expect(transactions["data"].count).to eq(3)
  end
    it "can get one transaction by it's id" do
      id = create(:transaction, invoice_id: @invoice.id).id

      get "/api/v1/transactions/#{id}"

      transaction = JSON.parse(response.body)

      expect(response).to be_successful
      expect(transaction["data"]["id"]).to eq(id.to_s)
    end

    it "can find an transaction by id" do
      id = @transaction_1.id

      get "/api/v1/transactions/find?id=#{id}"

      transaction = JSON.parse(response.body)

      expect(response).to be_successful
      expect(transaction["data"]["attributes"]["id"]).to eq(id)
    end

    it "can find all transactions with the same attribute" do

      get "/api/v1/transactions/find_all?created_at=1990-04-13T04:30:00.000Z"

      transactions = JSON.parse(response.body)

      expect(response).to be_successful

      expect(transactions["data"].count).to eq(2)
      expect(transactions["data"].first["id"]).to eq(@transaction_1.id.to_s)
      expect(transactions["data"].last["id"]).to eq(@transaction_2.id.to_s)
    end

    it 'can find a random transaction' do

      get "/api/v1/transactions/random"

      transaction = JSON.parse(response.body)
      expect(response).to be_successful
      expect(transaction.count).to eq(1)
    end

end
