class Product
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :unit_cost, type: Float,  default: 0.0
  field :quantity, type: Integer, default: 0
end
