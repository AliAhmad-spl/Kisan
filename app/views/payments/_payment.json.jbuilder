json.extract! payment, :id, :account_id, :customer_name, :amount, :status, :current_balance, :created_at, :updated_at
json.url payment_url(payment, format: :json)
