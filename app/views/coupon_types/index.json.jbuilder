json.array!(@coupon_types) do |coupon_type|
  json.extract! coupon_type, :id, :name
  json.url coupon_type_url(coupon_type, format: :json)
end
