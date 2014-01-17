json.array!(@users) do |user|
  json.extract! user, :id, :email_address, :name, :password_digest, :role, :organization_id
  json.url user_url(user, format: :json)
end
