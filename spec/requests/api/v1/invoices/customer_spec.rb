require 'rails_helper'

describe 'Invoice Customer API' do
  it "returns the Customer for an Invoice " do
    merchant_1 = create(:merchant)

    customer_1 = create(:customer)
    customer_2 = create(:customer)

    invoice_1 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer_1.id)
    invoice_2 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer_1.id)

    get "/api/v1/invoices/#{invoice_1.id}/customer"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer.count).to eq(1)
    expect(customer["data"]["id"]).to eq(customer_1.id.to_s)
  end
end
