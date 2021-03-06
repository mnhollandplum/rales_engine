class Api::V1::Merchants::InvoicesController < ApplicationController
  def index
    render json: InvoiceSerializer.new(Merchant.includes(:invoices).find(params[:merchant_id]).invoices)
  end
end
