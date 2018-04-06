CouponType.create(name: "Percentage")
CouponType.create(name: "Discount")
CouponType.create(name: "Discount&Cashback")
CouponType.create(name: "Percentage&Cashback")
CouponType.create(name: "BOGO")

10.times do
Outlet.create(name: Faker::Company.name)
end