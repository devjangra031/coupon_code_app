require 'test_helper'

class CouponCodesControllerTest < ActionController::TestCase
  setup do
    @coupon_code = coupon_codes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:coupon_codes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create coupon_code" do
    assert_difference('CouponCode.count') do
      post :create, coupon_code: { active: @coupon_code.active, applicable_outlet_ids: @coupon_code.applicable_outlet_ids, cashback_value: @coupon_code.cashback_value, code: @coupon_code.code, end_date: @coupon_code.end_date, maximum_discount: @coupon_code.maximum_discount, minimum_delivery_amount_after_discount: @coupon_code.minimum_delivery_amount_after_discount, start_date: @coupon_code.start_date, type: @coupon_code.type, value: @coupon_code.value }
    end

    assert_redirected_to coupon_code_path(assigns(:coupon_code))
  end

  test "should show coupon_code" do
    get :show, id: @coupon_code
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @coupon_code
    assert_response :success
  end

  test "should update coupon_code" do
    patch :update, id: @coupon_code, coupon_code: { active: @coupon_code.active, applicable_outlet_ids: @coupon_code.applicable_outlet_ids, cashback_value: @coupon_code.cashback_value, code: @coupon_code.code, end_date: @coupon_code.end_date, maximum_discount: @coupon_code.maximum_discount, minimum_delivery_amount_after_discount: @coupon_code.minimum_delivery_amount_after_discount, start_date: @coupon_code.start_date, type: @coupon_code.type, value: @coupon_code.value }
    assert_redirected_to coupon_code_path(assigns(:coupon_code))
  end

  test "should destroy coupon_code" do
    assert_difference('CouponCode.count', -1) do
      delete :destroy, id: @coupon_code
    end

    assert_redirected_to coupon_codes_path
  end
end
