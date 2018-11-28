class Api::V1::InvoicesItemsController < ApplicationController
  def index
    render json: InvoiceItem.all
  end

  def show
    render json: InvoiceItem.find(params[:id])
  end
end
