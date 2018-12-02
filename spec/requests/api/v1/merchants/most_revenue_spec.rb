require 'rails_helper'

describe 'Merchant Business Intelligence' do
  it 'should return merchants based on most reveune' do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)

    customer_1 = create(:customer)
    customer_2 = create(:customer)

    invoice_1 = create(:invoice, status: "shipped", merchant_id: merchant_1.id, customer_id: customer_1.id)
    invoice_2 = create(:invoice, status: "shipped", merchant_id: merchant_1.id,customer_id: customer_1.id)
    invoice_3 = create(:invoice, status: "shipped", merchant_id: merchant_2.id, customer_id: customer_2.id)

    item_1 = create(:item, merchant: merchant_1)
    item_2 = create(:item, merchant: merchant_1)
    item_3 = create(:item, merchant: merchant_2)

    invoice_item_1 = create(:invoice_item, unit_price: 1, quantity: 1, item: item_1, invoice: invoice_1)
    invoice_item_2 = create(:invoice_item, unit_price: 2, quantity: 2, item: item_2, invoice: invoice_2)
    invoiceitem_3 = create(:invoice_item, unit_price: 3, quantity: 3, item: item_3, invoice: invoice_3)

    get '/api/v1/merchants/most_revenue?quantity=2'

    most_revenue_merchants = JSON.parse(response.body)

    expect(response).to be_successful
    expect(most_revenue_merchants["data"].count).to eq(2)
  end
end
