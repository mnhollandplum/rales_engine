class Api::V1::Merchants::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Merchant.includes(:items).find(params[:merchant_id]).items)
  end
end
