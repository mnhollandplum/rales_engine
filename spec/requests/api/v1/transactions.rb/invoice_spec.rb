require 'rails_helper'

describe "Transaction's Invoice API" do
  it "returns the invoice for a transaction" do
    merchant_1 = create(:merchant)

    customer_1 = create(:customer)

    invoice_1 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer_1.id)
    invoice_2 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer_1.id)

    transaction_1 = create(:transaction, invoice_id: invoice_1.id)

    transaction_2 = create(:transaction, invoice_id: invoice_2.id)

    get "/api/v1/transactions/#{transaction_1.id}/invoice"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice.count).to eq(1)
    expect(invoice["data"]["id"]).to eq(invoice_1.id.to_s)

    get "/api/v1/transactions/#{transaction_2.id}/invoice"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice.count).to eq(1)
    expect(invoice["data"]["id"]).to eq(invoice_2.id.to_s)
  end
end
