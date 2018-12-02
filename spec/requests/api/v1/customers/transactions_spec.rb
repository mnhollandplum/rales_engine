require 'rails_helper'

describe 'Customer Transactions API' do
  it "returns all transactions for an Customer " do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)

    customer_1 = create(:customer)
    customer_2 = create(:customer)

    invoice_1 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer_1.id)
    invoice_2 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer_1.id)
    invoice_3 = create(:invoice, merchant_id: merchant_2.id, customer_id: customer_2.id)

    transaction_1 = create(:transaction, invoice_id: invoice_1.id)
    transaction_2 = create(:transaction, invoice_id: invoice_2.id)
    transaction_3 = create(:transaction, invoice_id: invoice_3.id)


    get "/api/v1/customers/#{customer_1.id}/transactions"

    transactions = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transactions["data"].count).to eq(2)
    expect(transactions["data"].first["id"]).to eq(transaction_1.id.to_s)
    expect(transactions["data"].last["id"]).to eq(transaction_2.id.to_s)
    expect(transactions["data"]).not_to include(transaction_3.id.to_s)

    get "/api/v1/customers/#{customer_2.id}/transactions"

    transactions = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transactions["data"].count).to eq(1)
    expect(transactions["data"].first["id"]).to eq(transaction_3.id.to_s)
    expect(transactions["data"]).not_to include(transaction_2.id.to_s)
    expect(transactions["data"]).not_to include(transaction_1.id.to_s)
  end
end
