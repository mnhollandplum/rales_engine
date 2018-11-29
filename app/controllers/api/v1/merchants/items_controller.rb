class Api::V1::Merchants::ItemsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.includes(:items).find(params[:merchant_id]).items)
  end
end
