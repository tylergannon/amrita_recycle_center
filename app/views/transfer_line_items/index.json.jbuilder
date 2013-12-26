json.array!(@transfer_line_items) do |transfer_line_item|
  json.extract! transfer_line_item, :id, :credit, :account_id, :container_id, :gross_weight, :net_weight
  json.url transfer_line_item_url(transfer_line_item, format: :json)
end
