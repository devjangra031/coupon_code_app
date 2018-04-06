json.array!(@coupon_codes) do |coupon_code|
  json.extract! coupon_code, :id, :code, :type, :value, :cashback_value, :start_date, :end_date, :active, :applicable_outlet_ids, :minimum_delivery_amount_after_discount, :maximum_discount
  json.url coupon_code_url(coupon_code, format: :json)
end
