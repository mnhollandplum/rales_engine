class InvoiceItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :item_id, :invoice_id, :unit_price, :quantity, :created_at, :updated_at
end
