json.array!(@subscriptions) do |subscription|
  json.extract! subscription, :id, :organization_id
  json.url subscription_url(subscription, format: :json)
end
