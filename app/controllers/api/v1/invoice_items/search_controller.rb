class Api::V1::InvoiceItems::SearchController < ApplicationController
  def show
    render json: InvoiceItemSerializer.new(InvoiceItem.find_by(invoice_item_params))
  end

  private

  def invoice_item_params
    params.permit(:invoice_id, :item_id)
  end
end
