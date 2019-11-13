json.extract! user_option, :id, :user_id, :email, :sms, :notification, :subscription, :created_at, :updated_at
json.url user_option_url(user_option, format: :json)
