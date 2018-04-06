class CouponCode
  include Mongoid::Document
  include Mongoid::Timestamps

  field :code, type: String
  field :type, type: String
  field :value, type: Integer
  field :cashback_value, type: Integer
  field :start_date, type: Time
  field :end_date, type: Time
  field :active, type: Mongoid::Boolean
  field :applicable_outlet_ids, type: Array, default: []
  field :minimum_delivery_amount_after_discount, type: Integer
  field :maximum_discount, type: Integer

  def self.apply_coupon(cart_items, code, outlet_id)
    rv = validate_coupon_code(code, outlet_id)
    return rv if rv[:error]

    cart_total_price = cart_items.map{|v| (v[:quantity]*v[:unit_cost])}.sum
    rv = @coupon_code.send("#{@coupon_code.type.parameterize.underscore}_type", cart_items, cart_total_price)

    return rv
  end

  def percentage_type(cart_items, cart_total_price)
    discount = (cart_total_price / self.value)
    return calculate_new_price(discount, cart_total_price)
  end

  def discount_type(cart_items, cart_total_price)
    discount = (cart_total_price - self.value)
    return calculate_new_price(discount, cart_total_price)
  end

  def discount_cashback_type(cart_items, cart_total_price)
    discount = (cart_total_price - self.value)
    return calculate_new_price(discount, cart_total_price)
  end

  def percentage_cashback_type(cart_items, cart_total_price)
    discount = (cart_total_price / self.value)
    return calculate_new_price(discount, cart_total_price)
  end

  def bogo_type(cart_items, cart_total_price)
    lowest_item = {}
    lowest_value = 0.0
    cart_items.each_with_index do |cart_item, index|
      lowest_value = cart_item[:unit_cost] if index == 0
      if cart_item[:quantity] >= 2
        if cart_item[:unit_cost] <= lowest_value
          lowest_item = cart_item
          lowest_value = cart_item[:unit_cost]
        end
      end
    end

    if lowest_value < self.maximum_discount
      discount = lowest_value
    else
      discount = 0
    end
    cart_new_price = cart_total_price - discount

    if cart_new_price > self.minimum_delivery_amount_after_discount
      return { valid: true, message: "Coupon applied", discount: discount, cashback: self.cashback_value, new_price: cart_new_price }
    else
      return { error: true, valid: false, message: "Minimum Delivery Amount Not Sufficient" }
    end
  end

  private

  def calculate_new_price(discount, cart_total_price)
    discount = self.maximum_discount if discount > self.maximum_discount
    cart_new_price = cart_total_price - discount

    if cart_new_price > self.minimum_delivery_amount_after_discount
      return { valid: true, message: "Coupon applied", discount: discount, cashback: self.cashback_value, new_price: cart_new_price }
    else
      return { error: true, valid: false, message: "Minimum Delivery Amount Not Sufficient" }
    end
  end

  def self.validate_coupon_code(code, outlet_id)
    @coupon_code = CouponCode.where(code: code, active: true).first rescue nil

    if @coupon_code.nil?
      return { error: true, valid: false, message: "Coupon Invalid" }
    end

    unless Time.now.between?(@coupon_code.start_date, @coupon_code.end_date)
      return { error: true, valid: false, message: "Coupon Expired" }
    end

    unless @coupon_code.applicable_outlet_ids.empty?
      unless @coupon_code.applicable_outlet_ids.include?(outlet_id)
        return { error: true, valid: false, message: "Coupon not valid for current outlet" }
      end
    end

    return { sucess: true }
  end
end
