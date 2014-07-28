json.array!(@hosted_files) do |hosted_file|
  json.extract! hosted_file, :id, :node_id, :organization_id, :file_name, :friendly_name, :s3_url
  json.url hosted_file_url(hosted_file, format: :json)
end
