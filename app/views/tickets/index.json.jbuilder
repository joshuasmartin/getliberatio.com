json.array!(@tickets) do |ticket|
  json.extract! ticket, :id, :organization_id, :priority, :status, :category, :description
  json.url ticket_url(ticket, format: :json)
end
