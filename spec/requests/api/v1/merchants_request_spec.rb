require 'rails_helper'

describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"].count).to eq(3)
  end
    it "can get one merchant by it's id" do
      id = create(:merchant).id

      get "/api/v1/merchants/#{id}"

      merchant = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchant["data"]["id"]).to eq(id.to_s)
    end

    it "can find a merchant by id" do
      id = create(:merchant).id

      get "/api/v1/merchants/find?id=#{id}"

      merchant = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchant["data"]["attributes"]["id"]).to eq(id)
    end

    it "can find an merchant by id" do
      id = create(:merchant).id

      get "/api/v1/merchants/find?id=#{id}"

      merchant = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchant["data"]["attributes"]["id"]).to eq(id)
    end

    it "can find all merchants with the same attribute" do
      merchant_1 = create(:merchant, created_at: "1990-04-13 04:30:00 UTC")
      merchant_2 = create(:merchant, created_at: "1990-04-13 04:30:00 UTC")
      merchant_3 = create(:merchant, created_at: Time.now + 10.day)

      get "/api/v1/merchants/find_all?created_at=1990-04-13T04:30:00.000Z"

      merchants = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchants["data"].count).to eq(2)
      expect(merchants["data"].first["id"]).to eq(merchant_1.id.to_s)
      expect(merchants["data"].last["id"]).to eq(merchant_2.id.to_s)
    end

    it 'can find a random invoice' do
      create_list(:merchant, 3)

      get "/api/v1/merchants/random"

      merchant = JSON.parse(response.body)
      expect(response).to be_successful
      expect(merchant.count).to eq(1)
    end

end
