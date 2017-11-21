json.extract! item, :id, :trx_type, :trx_date, :amount, :name, :created_at, :updated_at
json.url item_url(item, format: :json)
