json.array!(@transfers) do |transfer|
  json.extract! transfer, :id, :transferred_at
  json.url transfer_url(transfer, format: :json)
end
