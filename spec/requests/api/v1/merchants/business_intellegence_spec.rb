describe "merchant business logic" do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)

    @customer = create(:customer)

    @item_1 = create(:item, merchant_id: @merchant_1.id, unit_price: 100)
    @item_2 = create(:item, merchant_id: @merchant_2.id, unit_price: 10)
    @item_3 = create(:item, merchant_id: @merchant_3.id, unit_price: 1)

    @invoice_1 = create(:invoice, customer_id: @customer.id, merchant_id: @merchant_1.id)
    @invoice_2 = create(:invoice, customer_id: @customer.id, merchant_id: @merchant_2.id)
    @invoice_3 = create(:invoice, customer_id: @customer.id, merchant_id: @merchant_3.id)

    @invoice_item_1 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id)
    @invoice_item_2 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id)
    @invoice_item_3 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id)
    @invoice_item_4 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id)

    @invoice_item_5 = create(:invoice_item, item_id: @item_2.id, invoice_id: @invoice_2.id)
    @invoice_item_6 = create(:invoice_item, item_id: @item_2.id, invoice_id: @invoice_2.id)

    @invoice_item_7 = create(:invoice_item, item_id: @item_3.id, invoice_id: @invoice_3.id)

    @transaction_1 = create(:transaction, invoice_id: @invoice_1.id)
    @transaction_2 = create(:transaction, invoice_id: @invoice_2.id)
    @transaction_3 = create(:transaction, invoice_id: @invoice_3.id)
  end
  it 'can find top x merchants by revenue' do

    get '/api/v1/merchants/most_revenue?quantity=2'

    # top_merchants_revenue = JSON.parse(response.body)

    expect(response).to be_successful
  end

  it 'can find the top x merchants by number of items sold' do

    get '/api/v1/merchants/most_items?quantity=2'

    # top_merchants_items = JSON.parse(response.body)

    expect(response).to be_successful
  end

  it 'can find total revenue of all merchants by date' do

    get "/api/v1/merchants/revenue?date=#{@invoice_1.created_at}"

    # revenue_by_date = JSON.parse(response.body)

    expect(response).to be_successful
  end

end
