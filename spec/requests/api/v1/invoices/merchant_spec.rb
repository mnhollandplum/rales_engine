require 'rails_helper'

describe 'Invoice Merchant API' do
  it "returns the Merchant for an Invoice " do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)

    customer_1 = create(:customer)

    invoice_1 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer_1.id)
    invoice_2 = create(:invoice, merchant_id: merchant_2.id, customer_id: customer_1.id)

    get "/api/v1/invoices/#{invoice_1.id}/merchant"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant.count).to eq(1)
    expect(merchant["data"]["id"]).to eq(merchant_1.id.to_s)

    get "/api/v1/invoices/#{invoice_2.id}/merchant"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant.count).to eq(1)
    expect(merchant["data"]["id"]).to eq(merchant_2.id.to_s)
  end
end
