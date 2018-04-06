json.array!(@products) do |product|
  json.extract! product, :id, :name, :unit_cost
  json.url product_url(product, format: :json)
end
