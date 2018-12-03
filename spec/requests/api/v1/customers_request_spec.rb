require 'rails_helper'

describe "Customers API" do
  it "sends a list of customers" do
    create_list(:customer, 3)

    get '/api/v1/customers'

    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers["data"].count).to eq(3)
  end
    it "can get one customer by it's id" do
      id = create(:customer).id

      get "/api/v1/customers/#{id}"

      customer = JSON.parse(response.body)

      expect(response).to be_successful
      expect(customer["data"]["id"]).to eq(id.to_s)
    end

    it "can find a customer by attributes" do
      id = create(:customer).id

      get "/api/v1/customers/find?id=#{id}"

      customer = JSON.parse(response.body)

      expect(response).to be_successful
      expect(customer["data"]["attributes"]["id"]).to eq(id)

      first_name = create(:customer).first_name

      get "/api/v1/customers/find?first_name=#{first_name}"

      customer = JSON.parse(response.body)

      expect(response).to be_successful
      expect(customer["data"]["attributes"]["first_name"]).to eq(first_name)


      last_name = create(:customer).last_name

      get "/api/v1/customers/find?last_name=#{last_name}"

      customer = JSON.parse(response.body)

      expect(response).to be_successful
      expect(customer["data"]["attributes"]["last_name"]).to eq(last_name)
    end

    it "can find all customers with the same attribute" do
      customer_1 = create(:customer, first_name: "Buffy")
      customer_2 = create(:customer, first_name: "Buffy")
      customer_3 = create(:customer, first_name: "Willow")

      get "/api/v1/customers/find_all?first_name=#{customer_1.first_name}"

      customers = JSON.parse(response.body)

      expect(response).to be_successful
      expect(customers["data"].count).to eq(2)
      expect(customers["data"].first["attributes"]["id"]).to eq(customer_1.id)
    end
end
