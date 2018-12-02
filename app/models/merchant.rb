require 'pry'
class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def self.most_revenue(limit = 5)
    select("merchants.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue")
   .joins(invoices: [:invoice_items, :transactions])
   .where(transactions: {result: "success"})
   .group(:id)
   .order("revenue DESC")
   .limit(limit)
  end
end
