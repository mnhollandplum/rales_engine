require 'pry'
class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def self.most_revenue(quantity)
   select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue')
     .joins(:invoices, invoices: [:invoice_items, :transactions])
     .where(transactions: {result: "success"})
     .group(:id)
     .order('revenue DESC')
     .limit(quantity)
  end

  def self.most_items(quantity)
    select('merchants.*, sum(invoice_items.quantity) AS revenue')
      .joins(:invoices, invoices: [:invoice_items, :transactions])
      .where(transactions: {result: "success"})
      .group(:id)
      .order('revenue DESC')
      .limit(quantity).to_a
  end


end
