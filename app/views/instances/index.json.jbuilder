json.array!(@instances) do |instance|
  json.extract! instance, :id, :application_id, :node_id
  json.url instance_url(instance, format: :json)
end
