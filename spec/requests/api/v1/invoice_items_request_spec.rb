require 'rails_helper'

describe "InvoiceItems API" do
  before(:each) do
    @merchant = create(:merchant)

    @customer = create(:customer)

    @item = create(:item, merchant_id: @merchant.id)

    @invoice = create(:invoice, customer_id: @customer.id, merchant_id: @merchant.id)

    @invoice_item_1 = create(:invoice_item, item_id: @item.id, invoice_id: @invoice.id, created_at: "1990-04-13 04:30:00 UTC")
    @invoice_item_2 = create(:invoice_item, item_id: @item.id, invoice_id: @invoice.id, created_at: "1990-04-13 04:30:00 UTC")
    @invoice_item_3 = create(:invoice_item, item_id: @item.id, invoice_id: @invoice.id)
  end

  it "sends a list of Invoice Items" do

    get '/api/v1/invoice_items'

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items["data"].count).to eq(3)
  end
    it "can get one Invoice Item by it's id" do
      id = create(:invoice_item, item_id: @item.id, invoice_id: @invoice.id).id


      get "/api/v1/invoice_items/#{id}"

      invoice_item = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice_item["data"]["id"]).to eq(id.to_s)
    end

    it "can find a invoice item by id" do
      id = @invoice_item_1.id

      get "/api/v1/invoice_items/find?id=#{id}"

      invoice_item = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice_item["data"]["attributes"]["id"]).to eq(id)
    end

    it "can find all invoice items with the same attribute" do

      get "/api/v1/invoice_items/find_all?created_at=1990-04-13T04:30:00.000Z"

      invoice_items = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice_items["data"].count).to eq(2)
      expect(invoice_items["data"].first["attributes"]["id"]).to eq(@invoice_item_1.id)
    end

    it 'can find a random invoice_item' do
      customer_1 = create(:customer, first_name: "Buffy")
      customer_2 = create(:customer, first_name: "Buffy")
      customer_3 = create(:customer, first_name: "Willow")

      get "/api/v1/invoice_items/random"

      invoice_item = JSON.parse(response.body)
      expect(response).to be_successful
      expect(invoice_item.count).to eq(1)
    end

end
