Fabricator(:product) do
  name { Faker::Commerce.product_name }
  unit_cost { Faker::Commerce.price }
end