require 'rails_helper'

describe 'Customer Invoices API' do
  it "returns all invoices for a customer" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)

    customer_1 = create(:customer)
    customer_2 = create(:customer)


    invoice_1 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer_1.id)
    invoice_2 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer_1.id)
    invoice_3 = create(:invoice, merchant_id: merchant_2.id, customer_id: customer_2.id)

    get "/api/v1/customers/#{customer_1.id}/invoices"

    invoices = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoices["data"].count).to eq(2)
    expect(invoices["data"].first["id"]).to eq(invoice_1.id.to_s)
    expect(invoices["data"].last["id"]).to eq(invoice_2.id.to_s)
    expect(invoices["data"]).not_to include(invoice_3.id.to_s)

    get "/api/v1/customers/#{customer_2.id}/invoices"

    invoices = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoices["data"].count).to eq(1)
    expect(invoices["data"].last["id"]).to eq(invoice_3.id.to_s)
    expect(invoices["data"]).not_to include(invoice_2.id.to_s)
    expect(invoices["data"]).not_to include(invoice_1.id.to_s)
  end
end
