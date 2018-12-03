require 'rails_helper'

describe Merchant, type: :model do
  before(:each) do
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
      @merchant_3 = create(:merchant)

      @customer = create(:customer)

      @item_1 = Item.create!(name: "Item 1", description: "This is description for item 1", unit_price: 1, merchant_id: @merchant_1.id, created_at: "2018-11-05", updated_at: "2018-11-05")
      @item_2 = Item.create!(name: "Item 2", description: "This is the description for item 2", unit_price: 2, merchant_id: @merchant_2.id, created_at: "2018-11-12", updated_at: "2018-11-12")

      @invoice_1 = Invoice.create!(customer_id: @customer.id, merchant_id: @merchant_1.id, status: "shipped", created_at: "2018-11-05", updated_at: "2018-11-05")
      @invoice_2 = Invoice.create!(customer_id: @customer.id, merchant_id: @merchant_1.id, status: "shipped", created_at: "2018-11-12", updated_at: "2018-11-12")
      @invoice_3 = Invoice.create!(customer_id: @customer.id, merchant_id: @merchant_2.id, status: "shipped", created_at: "2018-12-29", updated_at: "2018-12-29")

      @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 1, unit_price: @item_1.unit_price, created_at: "2018-11-11", updated_at: "2018-11-11")
      @invoice_item_2 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 2, unit_price: @item_1.unit_price, created_at: "2018-09-10", updated_at: "2018-09-10")
      @invoice_item_3 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_3.id, quantity: 3, unit_price: @item_2.unit_price, created_at: "2018-09-10", updated_at: "2018-09-10")

      @transaction_1 = Transaction.create!(invoice_id: @invoice_1.id, credit_card_number: 111111111, credit_card_expiration_date: "2022-11-11", result: "success", created_at: "2018-11-11", updated_at: "2018-11-11")
      @transaction_2 = Transaction.create!(invoice_id: @invoice_1.id, credit_card_number: 222222222, credit_card_expiration_date: "2022-11-2", result: "success", created_at: "2018-11-05", updated_at: "2018-11-05")
      @transaction_3 = Transaction.create!(invoice_id: @invoice_3.id, credit_card_number: 123456789, credit_card_expiration_date: "2021-11-01", result: "success", created_at: "2018-11-01", updated_at: "2018-11-01")
    end
  describe "validations" do
    it {should validate_presence_of :name}
  end

  describe "relationships" do
    it { should have_many :items}
    it { should have_many :invoices}
  end

  describe "class methods" do
    it 'returns the top x merchants ranked by total revenue' do
      top_merchants_revenue = Merchant.most_revenue(2).to_a

      expect(top_merchants_revenue.size).to eq(2)
      expect(top_merchants_revenue.first).to eq(@merchant_1)
      expect(top_merchants_revenue.last).to eq(@merchant_2)
    end

    it 'returns the top x merchants ranked by total number of items sold' do
      top_merchants_items = Merchant.most_items(2).to_a

      expect(top_merchants_items.size).to eq(2)

      expect(top_merchants_items.first.id).to eq(@merchant_1.id)
      expect(top_merchants_items.last.id).to eq(@merchant_2.id)
      expect(top_merchants_items).to_not include(@merchant_3.id)
    end
  end
end
