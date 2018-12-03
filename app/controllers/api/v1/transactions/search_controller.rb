class Api::V1::Transactions::SearchController < ApplicationController
  def show
    render json: TransactionSerializer.new(Transaction.find_by(transaction_params))
  end

  private

  def transaction_params
    params.permit(:credit_card_number, :credit_card_expiration_date, :result, :invoice_id)
  end
end
