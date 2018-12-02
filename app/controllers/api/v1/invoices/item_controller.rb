class Api::V1::Invoices::ItemController < ApplicationController
  def index
    render json: ItemSerializer.new(Invoice.includes(:items).find(params[:invoice_id]).items)
  end
end
