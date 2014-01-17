json.array!(@nodes) do |node|
  json.extract! node, :id, :role, :location, :name, :operating_system, :serial_number, :model_number, :organization_id
  json.url node_url(node, format: :json)
end
