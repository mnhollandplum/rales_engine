require 'csv'
namespace :import do
  desc  "Import data from CSV files"

  task data: :environment do

    CSV.foreach('db/data/customers.csv', headers: true, header_converters: :symbol) do |row|
      Customer.create(
        id: row[:id],
        first_name: row[:first_name],
        last_name: row[:last_name],
        created_at: row[:created_at],
        updated_at: row[:updated_at]
      )
    end
    puts "imported customer data"

    CSV.foreach('db/data/merchants.csv', headers: true, header_converters: :symbol) do |row|
      Merchant.create(
        id: row[:id],
        name: row[:name],
        created_at: row[:created_at],
        updated_at: row[:updated_at]
      )
    end
    puts "imported merchant data"

    CSV.foreach('db/data/invoices.csv', headers: true, header_converters: :symbol) do |row|
      Invoice.create(
        id: row[:id],
        status: row[:status],
        customer_id: row[:customer_id],
        merchant_id: row[:merchant_id],
        created_at: row[:created_at],
        updated_at: row[:updated_at]
      )
    end
    puts "imported invoice data"

    CSV.foreach('db/data/items.csv', headers: true, header_converters: :symbol) do |row|
      Item.create!(
        id: row[:id],
        name: row[:name],
        description: row[:description],
        unit_price: row[:unit_price],
        merchant_id: row[:merchant_id],
        created_at: row[:created_at],
        updated_at: row[:updated_at]
      )
    end
    puts "imported item data"

    CSV.foreach('db/data/transactions.csv', headers: true,
      header_converters: :symbol) do |row|
      Transaction.create!(
        id: row[:id],
        credit_card_number: row[:credit_card_number],
        credit_card_expiration_date: row[:credit_card_expiration_date],
        result: row[:result],
        invoice_id: row[:invoice_id],
        created_at: row[:created_at],
        updated_at: row[:updated_at]
      )

    end
    puts "imported transaction data"

    CSV.foreach('db/data/invoice_items.csv', headers: true, header_converters: :symbol) do |row|
      InvoiceItem.create(
        id: row[:id],
        quantity: row[:quantity],
        unit_price: row[:unit_price],
        item_id: row[:item_id],
        invoice_id: row[:invoice_id],
        created_at: row[:created_at],
        updated_at: row[:updated_at]
      )
    end
    puts "imported invoice_item data"
  end
end
