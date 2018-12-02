class Api::V1::Items::InvoiceItemsController < ApplicationController

  def index
    render json: InvoiceItemSerializer.new(Item.includes(:invoice_items).find(params[:item_id]).invoice_items)
  end
end
  
