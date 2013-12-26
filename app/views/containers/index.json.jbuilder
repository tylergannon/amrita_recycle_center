json.array!(@containers) do |container|
  json.extract! container, :id, :name, :capacity, :empty_weight
  json.url container_url(container, format: :json)
end
