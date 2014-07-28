json.array!(@notes) do |note|
  json.extract! note, :id, :node_id, :organization_id, :title, :contents, :user_id
  json.url note_url(note, format: :json)
end
