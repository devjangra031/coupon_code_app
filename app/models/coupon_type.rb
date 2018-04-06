class CouponType
  include Mongoid::Document
  include Mongoid::Timestamps

  VALID_COUPON_TYPES = ['Percentage','Discount','Discount&Cashback','Percentage&Cashback','BOGO']

  field :name,  type: String

  validates :name, uniqueness: true
  validate :validate_coupon_name

  def validate_coupon_name
    if ([self.name] - VALID_COUPON_TYPES).length == 0
      return false
    else
      self.errors.add(:name, 'Invalid CouponType is passed')
      return true
    end
  end

  def self.find_applicable_coupon_types
    self.all.map(&:name)
  end
end
