json.array!(@outlets) do |outlet|
  json.extract! outlet, :id, :name
  json.url outlet_url(outlet, format: :json)
end
