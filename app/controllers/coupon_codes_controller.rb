class CouponCodesController < ApplicationController
  before_action :set_coupon_code, only: [:show, :edit, :update, :destroy]

  # GET /coupon_codes
  # GET /coupon_codes.json
  def index
    @coupon_codes = CouponCode.all
  end

  # GET /coupon_codes/1
  # GET /coupon_codes/1.json
  def show
  end

  # GET /coupon_codes/new
  def new
    @coupon_code = CouponCode.new
  end

  # GET /coupon_codes/1/edit
  def edit
  end

  # POST /coupon_codes
  # POST /coupon_codes.json
  def create
    @coupon_code = CouponCode.new(coupon_code_params)

    respond_to do |format|
      if @coupon_code.save
        format.html { redirect_to @coupon_code, notice: 'Coupon code was successfully created.' }
        format.json { render action: 'show', status: :created, location: @coupon_code }
      else
        format.html { render action: 'new' }
        format.json { render json: @coupon_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coupon_codes/1
  # PATCH/PUT /coupon_codes/1.json
  def update
    respond_to do |format|
      if @coupon_code.update(coupon_code_params)
        format.html { redirect_to @coupon_code, notice: 'Coupon code was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @coupon_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coupon_codes/1
  # DELETE /coupon_codes/1.json
  def destroy
    @coupon_code.destroy
    respond_to do |format|
      format.html { redirect_to coupon_codes_url }
      format.json { head :no_content }
    end
  end

  def apply_coupon
    coupon_code = params["coupon_code"]
    rv = CouponCode.apply_coupon(session["cart_items"], coupon_code, session["outlet_id"])

    render json: rv
  end

  private

  def set_coupon_code
    @coupon_code = CouponCode.find(params[:id])
  end

  def check_coupon_code
    @coupon_code = CouponCode.where(code: params["coupon_code"]).first rescue nil

    if @coupon_code.nil?
      flash[:error] = "Invalid Coupon"
      redirect_to cart_items_cart_items_path
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def coupon_code_params
    params.require(:coupon_code).permit(:code, :type, :value, :cashback_value, :start_date, :end_date, :active, :minimum_delivery_amount_after_discount, :maximum_discount, :applicable_outlet_ids => [])
  end
end
