json.array!(@subscriptions) do |subscription|
  json.extract! subscription, :id, :start_date
  json.url subscription_url(subscription, format: :json)
end
