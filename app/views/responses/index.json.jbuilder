json.array!(@responses) do |response|
  json.extract! response, :id, :ticket_id, :content, :user_id
  json.url response_url(response, format: :json)
end
