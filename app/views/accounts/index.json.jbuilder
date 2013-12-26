json.array!(@accounts) do |account|
  json.extract! account, :id, :category_id, :location_id, :slug, :incoming
  json.url account_url(account, format: :json)
end
